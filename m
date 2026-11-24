Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9C606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4Sx6EYH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2347D10F512;
	Tue, 24 Nov 2026 12:00:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095FE10F525;
 Tue, 24 Nov 2026 12:00:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46FC3601D7;
 Tue, 24 Nov 2026 12:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827EF1F000CA;
 Tue, 24 Nov 2026 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795521605;
 bh=VJLol9QNgQ8sIKCWFbA7w8PHUKOB+IRHa3RMNrUFjZU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=O4Sx6EYHLxDJiMmqs4rZeop3a92PV+k7ISEmre12ro3B6AL5qxuvuKcgFaiUtVEWN
 yuj0fP+wK86JN0o444myEpVzsj3hhv9iDCFGeZLk76Zs2il91I6GnCZejBdPbyd2bj
 +UdR4hbGIzxUSmqAtzL/+jXbnsE2qqKsCk/2dFq1UehRWx3YtBCo5QgqUBHRpacmOc
 ewAj6/7+pcHe3ZsfcRVvK5W/7cvOrZgqBzINKTqO41mN3R61P+PO0pAqT6b6CpPZE7
 zMhu5W96onuEsbJeMaKP5idsB0M6difo03mREs8IvdHiygXE9GMT79y3/b7wd3TmnZ
 R700/Jo99UmgA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:59:59 +0100
Message-Id: <DN3FABTSKUC6.2VK9DKQIBAPFO@kernel.org>
Subject: Re: [PATCH v3 2/2] nova-core: only bind to GPUs when explicitly
 requested
Cc: <airlied@redhat.com>, "Lyude Paul" <lyude@redhat.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
 <20261124-nova-nouveau-gsp-v3-2-e1440479ded6@redhat.com>
In-Reply-To: <20261124-nova-nouveau-gsp-v3-2-e1440479ded6@redhat.com>
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

On Tue Nov 24, 2026 at 6:50 AM CET, Dave Airlie via B4 Relay wrote:
> +config NOVA_CORE_BIND_GSP
> +	bool "Make nova-core the default driver for GSP-capable GPUs"
> +	depends on NOVA_CORE
> +	default n

I've replied to v2 regarding this: https://lore.kernel.org/nova-gpu/DN3F752=
1O232.LXJ8JBRTSTPQ@kernel.org/
