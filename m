Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957F4CD3427
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 03:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDCB10E45E;
	Mon, 11 May 2026 03:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="aREZujNK";
	dkim-atps=neutral
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com
 [115.124.28.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A75410E45E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778470104; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=jfwMaxxdS67rnZ7uDXLCCcnFkL/ISIM8RleOqH0kHq8=;
 b=aREZujNKjIZlXRTVYYYA2CkIJiCf7rc8SVPo0SNR/mUIuzPR2jAKuciBd/z7fQDVowFedz3kzR1XZv2GDZcrTKH8zOUY59elbxXS/T3m/m903GWyJY5KRfXc3qCznjUg0U9WCA3EAGfmi3ToWOfJQ/xZYb3wilrdtNYdANE7nTrRFRLVO4m6Bjh1Qe1boaTUcD+FIPT/cfyUwe1F6ZYxuxtQgnNekoPRBK8svzbEseJksFkvDeur/C6S1eC0Qm3rREim2Xvrep/DtxuqUMyH+/YID/cWBptuNNPpmkhoZkDQgTjEj8SgvPxQ97tp6IIgGaIAEbES+3NicHqDxqvAmQ==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.5200654|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0540498-0.00904401-0.936906;
 FP=13402756081238397904|4|1|8|0|-1|-1|-1;
 HT=maildocker-contentspam033068016216; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.hUFenIT_1778470100; 
Received: from mail-ot1-f50.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hUFenIT_1778470100 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 11 May 2026 11:28:21 +0800
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7dbd801138eso2154796a34.1
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 20:28:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8iVtX89hz/CKYhXF/oFABlWLXGwbsw144VylDvD9WeEJqt7EQzENCoHlMJGCIil7oc9hwTKT1HJs8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq9ZD57n3DeA8C5wcry0nrdT4miVuKchdzAlQ4TQfbHBqEqJb2
 xXGkhknZ7x8+YhNt/cwqI5EcyvSpyYsgxYOolsOQB//FkFD2w5lpI/RGOch1F9ofO8qhx5LRQxV
 aNn/emzYhiRDuEq7aI+MD2QnVZPAm8JI=
X-Received: by 2002:a05:6820:55d4:10b0:696:aedf:bd53 with SMTP id
 006d021491bc7-699ab5711c2mr5737051eaf.9.1778470099831; Sun, 10 May 2026
 20:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260508142500.4922-1-syyang@lontium.com>
In-Reply-To: <20260508142500.4922-1-syyang@lontium.com>
From: Sunyun Yang <syyang@lontium.com>
Date: Mon, 11 May 2026 11:28:06 +0800
X-Gmail-Original-Message-ID: <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
X-Gm-Features: AVHnY4JrxkEnUWzQqJ698dfc7GDXi_1fOf_0kLN4nLtInSVNnYN34VzELwKRFYY
Message-ID: <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com, 
 xbpeng@lontium.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

<syyang@lontium.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=888=E6=97=A5=E5=91=A8=E4=
=BA=94 22:25=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Sunyun Yang <syyang@lontium.com>
>
> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
> - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
>
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9=
611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.=
yaml
> index 429a06057ae8..e0821a63d9d7 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yam=
l
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yam=
l
> @@ -4,19 +4,23 @@
>  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
>
>  maintainers:
>    - Vinod Koul <vkoul@kernel.org>
>
>  description: |
> -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDMI
> +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX and LT96=
11UXD
> +  are bridge devices which convert DSI to HDMI
>
>  properties:
>    compatible:
>      enum:
>        - lontium,lt9611
> +      - lontium,lt9611c
> +      - lontium,lt9611ex
>        - lontium,lt9611uxc
> +      - lontium,lt9611uxd
>
>    reg:
>      maxItems: 1
> --

Gentle ping.
Thanks.

> 2.34.1
>
