Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898D0CD4F21
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 01:41:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7D4410E050;
	Thu, 14 May 2026 01:41:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="MjUO20vK";
	dkim-atps=neutral
Received: from out28-105.mail.aliyun.com (out28-105.mail.aliyun.com
 [115.124.28.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF0B10E050
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 01:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778722857; h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 bh=paSUUNeM9d+Dg+dK0ePPB8BCcy3aHvmTkKmP2lDWFOQ=;
 b=MjUO20vKDOChLLpnh34n+L8BaCPxQzS6CjtMv6dByS3lSv0vIXvUt2FIhZ8GRlVFT7IYZDvmOLI+W5BN19+vfcOXnan+HLLdVaTAWSSPhUieYrMmAj0UTVTkLNCCM225ei83Ix9FsUsDzs4gtnA9Qjn5oaWo5GyP5OimhnAubGERHsZ7YIVIHB7iEHOYtNMpHUrmwXKBRa8AExbduN2zA9kUNodP/bmqMJTV7YOB+SuiHOzkfkJ6ppeowEb6pDfhaxK5ThCCJakW4Qc2laeG0pzUBWIg1L7LpqDf4dkhanZ4943O5fVFSAc/LIFDT/PvgkYONbJiQuYegpx9euYGtA==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.3534878|-1; CH=blue; DM=|OVERLOAD|false|;
 DS=CONTINUE|ham_regular_dialog|0.174381-0.0202541-0.805365;
 FP=11096877952077132768|13|1|9|0|-1|-1|-1;
 HT=maildocker-contentspam033037025160; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=1; RT=1; SR=0; TI=SMTPD_---.hWbPEmQ_1778722853; 
Received: from mail-oo1-f41.google.com(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hWbPEmQ_1778722853 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 14 May 2026 09:40:54 +0800
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-6966d0665baso4459076eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:40:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/SNjH7zoou5EMNVfEJ58uFf/4DKh2VansMCzkLVGji6ihZItXrNU3VM5jbsh5sp3eEqkgIpgrpIOE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRSaztfkoPm9/nlLkDpg1xxNRI7aDQs2jYELZjxmtcVgvRJvX/
 WfJYwc4yPdJJgSp6UbYXwNIKkset5dDmM+ZkOKa2BWQ2wFwNW9QqCJ299/Q3f9v9yh9WN8gFoBj
 o/ecnldIZW1S/87+eq9TMReZFuodEh0o=
X-Received: by 2002:a05:6820:818d:b0:694:980c:9609 with SMTP id
 006d021491bc7-69b7ab2de0emr2947356eaf.36.1778722852317; Wed, 13 May 2026
 18:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260507034049.97765-1-syyang@lontium.com>
 <20260513192515.GA1728398-robh@kernel.org>
In-Reply-To: <20260513192515.GA1728398-robh@kernel.org>
From: Sunyun Yang <syyang@lontium.com>
Date: Thu, 14 May 2026 09:40:40 +0800
X-Gmail-Original-Message-ID: <CAFQXuNb8WBrCvBpdKdpCUSdrS+qEWjyETE0qD09LH5HOfjOH7A@mail.gmail.com>
X-Gm-Features: AVHnY4IkVGhomaeI1wAG41IL6-oFivJQBQuT2mzo4d72gRbFAuy9FvNbwo8LR2Q
Message-ID: <CAFQXuNb8WBrCvBpdKdpCUSdrS+qEWjyETE0qD09LH5HOfjOH7A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
 neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org, mripard@kernel.org, 
 Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se, 
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

Rob Herring <robh@kernel.org> =E4=BA=8E2026=E5=B9=B45=E6=9C=8814=E6=97=A5=
=E5=91=A8=E5=9B=9B 03:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, May 07, 2026 at 11:40:49AM +0800, syyang@lontium.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> >
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual por=
t
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> >
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > ---
> >  .../bindings/display/bridge/lontium,lt9611.yaml           | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,l=
t9611.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt961=
1.yaml
> > index 429a06057ae8..b20a43456b01 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.y=
aml
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9611.y=
aml
> > @@ -4,19 +4,23 @@
> >  $id: http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >
> > -title: Lontium LT9611(UXC) 2 Port MIPI to HDMI Bridge
> > +title: Lontium LT9611(UXC/C/EX/UXD) 2 Port MIPI DSI to HDMI Bridge
> >
> >  maintainers:
> >    - Vinod Koul <vkoul@kernel.org>
> >
> >  description: |
> > -  The LT9611 and LT9611UXC are bridge devices which convert DSI to HDM=
I
> > +  The LT9611=E3=80=81LT9611UXC=E3=80=81LT9611C=E3=80=81LT9611EX and LT=
9611UXD
>
> Use a normal ','.
>
> > +  are bridge devices which convert DSI to HDMI
>
> Missing period.
>

thanks, Rob Herring.

we will fixed in patch v7.

> >
> >  properties:
> >    compatible:
> >      enum:
> >        - lontium,lt9611
> >        - lontium,lt9611uxc
> > +      - lontium,lt9611c
> > +      - lontium,lt9611ex
> > +      - lontium,lt9611uxd
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.34.1
> >
