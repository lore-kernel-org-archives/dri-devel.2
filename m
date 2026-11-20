Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AD1606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEDEMp22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0784E1129C9;
	Fri, 20 Nov 2026 12:52:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D541129C9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:52:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AB0F46579
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C7B1F000E1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795179166;
 bh=YTa99/gQDpgz73/BKE8NpgRyese8EPLHJ7fjfDiIXEQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=AEDEMp22Gu+k0c/UKkXbC6nZTZP9xlNJF5eAMpFc7UO3N5PXkYJzzAFlDCCAdr3Dr
 curY0fehQWgiI1SJtwxycfQTLDisLPAsZASMKddezyS1gTPpv1Ufvv5QASDrU7Csf0
 5GD7r1LJES1bJns64Ivg/okbsEyHjeBjbuI9q0gpib+pDiu/OpjFBYkb+ilxTY2esG
 3WCWBV8sLUij03xyLBsPodU6EFs5grDXRvL9rX6g42EuuqRvh1aP9gz+YJr/68iV1H
 EHXIN5ExCon9ApnVfDwCDDxc2qLp2sTEndnfKT/OoIs45NIImDlRtBl0IEX/QDM255
 C2CiMexmilgpw==
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3ada7d53082so8943341fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 04:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH7kaXHSQkv48ImxWCsPHICIJQL+FP4ONIA1ZYByWFag5p+WBnaAzwmFOB57K3yVZ36E35gaq70DLw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8kVEfZW6wR41MinJubaUS9oiQQMakqYYqLyhjmcr4/Hzh7aTA4
 R2n39eNuCtIhJuuhFOfe78TsCvkOwt7i4OFCn5Ud6uUy48aH0Qu7T+eEDoBzG5/ydkoPWr2f//4
 vHeai/FfqeMye7xVykEEBi6qsrfrbOq8=
X-Received: by 2002:a05:651c:54e:b0:3ae:6ed3:a9b7 with SMTP id
 38308e7fff4ca-3ae7b7fc14dmr11474761fa.22.1795179165255; Fri, 20 Nov 2026
 04:52:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <3471545.44csPzL39Z@rafael.j.wysocki>
 <CAJZ5v0gB+ktRht4j8SjSTo-mqmsRR+e5m1sfc6j5gnGop6=BJg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gB+ktRht4j8SjSTo-mqmsRR+e5m1sfc6j5gnGop6=BJg@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:52:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUzQ7+NEi8DAgCy=Fx-i+a77Cc2Q_U2zwt=wVqrxcc7w@mail.gmail.com>
X-Gm-Features: Aa3M54p6ev89u-Dya_X8LkTxv_6m4WAMWGfQWDQnspC5qiUwdt1yYxqWfIzI8SA
Message-ID: <CAJZ5v0hUzQ7+NEi8DAgCy=Fx-i+a77Cc2Q_U2zwt=wVqrxcc7w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ACPI: glue: Rework ACPI companion lookup related
 to device type
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 13, 2026 at 5:27=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Nov 4, 2026 at 10:12=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > Hi All,
> >
> > The ACPI "glue" code is responsible for binding Linux devices (like pla=
tform
> > devices for one example) to their ACPI companions (represented by struc=
t
> > acpi_device objects).  This is done by acpi_device_notify() when the gi=
ven
> > device is registered.
> >
> > If the device's ACPI companion is set already at that point, the bindin=
g
> > simply adds the device to the list of "physical nodes" associated with =
its
> > ACPI companion.  That's the case for PCI devices and platform devices, =
for
> > example.  However, there are cases in which the ACPI companion is not s=
et
> > upfront and it needs to be looked up via "lookup helpers" registered by
> > the subsystems the devices in question belong to.  This series changes
> > the "lookup helpers" representation and handling.
> >
> > Before the changes, the "lookup helpers" are represented by struct
> > acpi_bus_type objects which is doubly confusing because they have nothi=
ng
> > to do with bus types and because the "acpi_bus_type" name is also used
> > elsewhere.  Patch [1/3] renames struct acpi_bus_type to struct acpi_dev=
_type
> > because all of the existing "lookup helpers" operate on device types.
> >
> > Next, the registration and unregistration functions for "lookup helpers=
"
> > are defined to return an int, but all of their existing users effective=
ly
> > discard their return values (they are discarded right away or passed up=
 the
> > call chain and then discarded).  Patch [2/3] changes the return type of
> > those functions to void.
> >
> > Finally, since all of the existing "lookup helpers" match dev->type to
> > a certain device type, they can be rearranged to point to the device
> > types in question and provide a .find_companion() callback, and an
> > additional .setup() callback in one case.  This is done by patch [3/3]
> > and allows all of the affected code to be simplified quite a bit.
>
> In the absence of any feedback I will assume no objections or concerns
> and I'll queue up this lot for 7.5.

And so applied.

Thanks!
