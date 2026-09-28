Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073D6C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3894410E7C4;
	Mon, 28 Sep 2026 07:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="TxqEjZEG";
	dkim-atps=neutral
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436CD10E7C4
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 07:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790580503; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Jy+gdPpOvbttocgYqvQFWHsCT63CS+8NcC3CaY3Hgkt5iQR+5NWtGds2xRe/RmfeU3/7doB7i84KFYzIO+alvkQf3fiBKIguZAPwJxvXy5HVKMMrznpxG9RJ+fMTE2hW8QKYAqjXYJZ6DsNmho/JtIIFpu/2oAfx7v3OUpvlI4k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790580503;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qQ+wkOzeHNyM57nSul7YmRy/aNPxKWQliQukKQfWXHs=; 
 b=hZa6oVL6IRlZ4EsQqAOLknfLGs2ruIgWh9aDZCQciY2Viqv+6a1gyoHgB+XxsG5HcsCDUEDwK9OrAd+2GUVZTe0hM5cuH6ANdP+oMWlkZwBrwci6612cqyfYAQjy2cGsGRJoACwe8ZA0VIks8RRjPUW9NM9ULrZ0zZw3UTU22+Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790580503; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=qQ+wkOzeHNyM57nSul7YmRy/aNPxKWQliQukKQfWXHs=;
 b=TxqEjZEGRsuygd3NwRjtGHrFIk2d1ohm3jbR43kD06NZaNrZv9yQRTOD0hxwGHGp
 GF60LiRGQ4yHogwunVMkgGUlrQv4VqqyQGSU9X3U1bVDITUAw9D2AkF7Et2p7qv6HL6
 2mP9xDjjdh8od2uJW+2hjESsw81u6Mbjrlwd6jUlHveTOq7X7DBDXdjprd4J8Hl8L9D
 QjFkbw+aJvMi9Wr0KsCv+RoIobryk3BMRO9nnEjuKnSMi4d757GOhTJcGRuScgHDoYS
 WD54YKoIRzX9vFSuYSNSgceQSdhLXiUAXaqYdE+BtHzr8RdIQSLT+ZosOQ+DQc51HCc
 OZBSFTRScA==
Received: by smtp.zohomail.com with SMTPS id 1790580502126809.1352746111535;
 Mon, 28 Sep 2026 00:28:22 -0700 (PDT)
Message-ID: <ef09da01179a1ec707ae33b7e6aa5252ebe4fa69.camel@icenowy.me>
Subject: Re: [PATCH 0/2] drm/bridge: th1520-dw-hdmi: Two fixes
From: Icenowy Zheng <uwu@icenowy.me>
To: Felix Gu <ustc.gu@gmail.com>, Drew Fustini <fustini@kernel.org>, Guo Ren
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Andrzej Hajda	
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman	 <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 28 Sep 2026 15:28:13 +0800
In-Reply-To: <20260321-th1520-v1-0-ec877197770d@gmail.com>
References: <20260321-th1520-v1-0-ec877197770d@gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

=E5=9C=A8 2026-03-21=E5=85=AD=E7=9A=84 03:12 +0800=EF=BC=8CFelix Gu=E5=86=
=99=E9=81=93=EF=BC=9A
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Sorry for forgetting this patchset. I'm going to apply it.

This patchset should be now:

Cc: stable@vger.kernel.org

Thanks,
Icenowy

> ---
> Felix Gu (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: th1520-dw-hdmi: Fix error chec=
k on dw_hdmi_probe()
> return value
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/bridge: th1520-dw-hdmi: Fix remove() c=
allback
>=20
> =C2=A0drivers/gpu/drm/bridge/th1520-dw-hdmi.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: b5d083a3ed1e2798396d5e491432e887da8d4a06
> change-id: 20260321-th1520-f4326138c9bf
>=20
> Best regards,
