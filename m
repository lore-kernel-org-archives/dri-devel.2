Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932506071A08
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNB/0hnr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE6810FEE7;
	Wed,  4 Nov 2026 20:15:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F1C10FEED
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:15:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8034D60DA7;
 Wed,  4 Nov 2026 20:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0665B1F000C1;
 Wed,  4 Nov 2026 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793823327;
 bh=zsWAWduFeZpOhb2GkeIpoaCj3XU9Zxz05E+c4bxniHE=;
 h=From:To:Cc:Subject:Date;
 b=ZNB/0hnrB2B2HN0buFTwcHzrDBEpJPJ0NJNXkv6pSrOGE7S/bduGulssOEOhmfGwI
 wuGAGai8ptAE6BrfxmqvotBD3vfjTNYab6cP8C8ppV8lGatq9SZWvrjJrXC9CZZXAH
 lBhnr61m0b51oZH/VaqD36lluriBZ5EpP989XVxqg7djRLN+j3kOjIMGualnbfjBog
 lMBHogmap/raMA1vAXiOCcgevvI77O2F1ArDOWjuf3v5BFpoiPFt++CPdYzacp9kkP
 jjVgjC+s3pzJyITPYG8t3/1KFhyqbGQ9X9DSVxnjAku3AWBZy06ODP0Pk7YSvkp7p+
 BFukF+DYx3OOw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] ACPI: glue: Rework ACPI companion lookup related to
 device type
Date: Wed, 04 Nov 2026 21:09:09 +0100
Message-ID: <3471545.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,

The ACPI "glue" code is responsible for binding Linux devices (like platform
devices for one example) to their ACPI companions (represented by struct
acpi_device objects).  This is done by acpi_device_notify() when the given
device is registered.

If the device's ACPI companion is set already at that point, the binding
simply adds the device to the list of "physical nodes" associated with its
ACPI companion.  That's the case for PCI devices and platform devices, for
example.  However, there are cases in which the ACPI companion is not set
upfront and it needs to be looked up via "lookup helpers" registered by
the subsystems the devices in question belong to.  This series changes
the "lookup helpers" representation and handling.

Before the changes, the "lookup helpers" are represented by struct
acpi_bus_type objects which is doubly confusing because they have nothing
to do with bus types and because the "acpi_bus_type" name is also used
elsewhere.  Patch [1/3] renames struct acpi_bus_type to struct acpi_dev_type
because all of the existing "lookup helpers" operate on device types.

Next, the registration and unregistration functions for "lookup helpers"
are defined to return an int, but all of their existing users effectively
discard their return values (they are discarded right away or passed up the
call chain and then discarded).  Patch [2/3] changes the return type of
those functions to void.

Finally, since all of the existing "lookup helpers" match dev->type to
a certain device type, they can be rearranged to point to the device
types in question and provide a .find_companion() callback, and an
additional .setup() callback in one case.  This is done by patch [3/3]
and allows all of the affected code to be simplified quite a bit.

Thanks!





