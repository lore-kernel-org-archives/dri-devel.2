Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F5606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=GGaWa+Mw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE1210FD2A;
	Wed, 28 Oct 2026 14:59:36 +0000 (UTC)
Received: from dormouse.ash.relay.mailchannels.net
 (dormouse.ash.relay.mailchannels.net [23.83.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 335DF10FD21
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:59:30 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B933742AA0;
 Wed, 28 Oct 2026 14:59:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com
 (trex-green-7.trex.outbound.svc.cluster.local [100.96.16.126])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4EEF042727;
 Wed, 28 Oct 2026 14:59:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Harmony: 78d2f747042e4d5d_1793199568528_2959092911
X-MC-Loop-Signature: 1793199568528:3909109401
X-MC-Ingress-Time: 1793199568528
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.16.126 (trex/8.0.2); Wed, 28 Oct 2026 14:59:28 +0000
Received: from offworld (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4jF9W359VYzYD; 
 Wed, 28 Oct 2026 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1793199568;
 bh=XE3Je+ocroISKFHAV5JHSwDyP53+LTrgvXdNFl0b/Vo=;
 h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
 b=GGaWa+MwRpGj+V0CBz4xbroyakBCHQenmvHnq/o7cQqoJrgM1qLdgSG9hhmj31gQb
 VG2lJrz6tgCacbSb49HP9NlBVrDdKfbK/yNf+qiog+J9XS2GDK3G3EwtMKV/Vna+fP
 67BgL4Rcd5b8XWWgG8fkEz2R8s/+zhyX//YLt/840k6U+4rXBhMPSLxVEg/RMocTYu
 ApIo5WpF5WO81u+Kz1OHrVlTdM92edipvDrBC9Rwuqp74L6ROIwDjUhdCC+OnyXCPI
 p5k5HrNcPS0Vl1IxgVp5iLANMmcsDtu2CX5R56JsnULeMwkYNVtFEbmIHANr2XkODq
 ZjxpCnl4cXSoA==
Date: Wed, 28 Oct 2026 07:59:24 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Christian =?utf-8?B?S8Ovwr/CvW5pZw==?= <christian.koenig@amd.com>
Cc: sumit.semwal@linaro.org, phasta@kernel.org,
 benjamin.gaignard@collabora.com, jstultz@google.com,
 tjmercier@google.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] dma-buf: system_heap: 2MB chunks on x86
Message-ID: <20261028145924.5gcjfjbjd2ejgozt@offworld>
References: <20260928195850.1982569-1-dave@stgolabs.net>
 <20261007120745.bvhqqa6cowqnt3jc@offworld>
 <52a82bea-3105-4bb5-a6e0-b1a0e3b808b3@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <52a82bea-3105-4bb5-a6e0-b1a0e3b808b3@amd.com>
User-Agent: NeoMutt/20220429
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026, Christian K=EF=BF=BDnig wrote:

>I've just pushed patch #1 to drm-misc-fixes.

Thanks.

>
>I'm still wondering if #2 is actually optimal. From what I've heard only 2=
MiB should be used and especially 64k doesn't make sense any more on modern=
 HW.

I have no problem removing the 64k for x86 in v3.
