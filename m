Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FA8FED3E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2688410F680;
	Fri, 24 Apr 2026 18:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6bIOA1d";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF7410F680
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 18:27:26 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso5169508c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 11:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777055246; cv=none;
 d=google.com; s=arc-20240605;
 b=G6TfK3ZepsUtdDX6qX11cwhN/vUIJTHUtL5FBFtbt3x1dKM7Z5vc/umQ4CpdTO7bp8
 lTtWlylpfrVwxO5P9exnnomcqVVnJ5sNn/39toGmuZ7aB74xpNoGlblIjPejQ1UoydcL
 xAEzBsdEmOGKJiIStumYrlYgUKPhTO2cQ1obJejS3mTMHXD2nER+p+HXS8R3euaOUVn5
 aHdMMHM5y54ii3+sXvKVT1NBd5bDWmgJplC9PZkJpIuQsqvI51uKt5Lwm0NJ4hy5Izz+
 IpOTSqLPHC6ktpJQPPa0G6v8iHQWl49QRNsqaa8Tt7YG+bKArAwmT/QZMJTcVphwAMbp
 0xwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8fKE6uWynXvOQK+WQLf5kO4iqhFOCsKdnL+aW04mVOs=;
 fh=B+RAmfCHj7yRmfaxI6/wCI0J+tHrAvhluX2/rQLUlaA=;
 b=cSLELo3foZG4CdGuL9WtZ+j9y05PoWVHt9X77py/+4zu2+WeTMc4bMhMon+6XhwXxP
 gGwahjR4oA7lpbAU6SFL8cJpIJTzChY5ZI9SaiI2tNCSkBS0N/UprpjkhUATMjwIE2t9
 B5Y0lueGMq6p+Zr008BfpSN0ba/t9eMPufshRsBHMPyc8EaSfhESGfwWZxzrTzNjzJ6o
 MdLjhXQ7at79dwtp5WQWbH6TD4awB9F7/Ht23Fhy6M349mhLREbQBXeYe+rnkv9bff7U
 RPNpfPeX3WTZoFQ4eDizVH5IXZj6y7WVpQQXcaibSV2cAqD46ZWW8iCLxqpIzj+xLTec
 YTdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777055246; x=1777660046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fKE6uWynXvOQK+WQLf5kO4iqhFOCsKdnL+aW04mVOs=;
 b=d6bIOA1dkMfvrWDK9cCwiV/RAt4vCecANdlBtHiN/j1UfzAVC6dTiThR91Wg/7lVOi
 XE0/eb0lkjnYNAG796nckwPgHirvYeAtw0+eiJYtOs9+oBEuJ8FgRYRuPHQSRKAN+8VD
 avVnHMT4xsae3ERBx+p6CnC/JjiMTIhwYu3m95oxwyRqMICt/E79uCTAlEEiIrGTMLz9
 C0MRBPb4l4HoSL3OiS+BtqhmrtWkwrLLXKS12HE+rnDBhfyobSGGFqWtgVzA4mwcmS/X
 UhXN6hjHLDs9+QGSCiJ0SWkacDwH1zCM2Vdj/QXz5zdcrfaec8xaVAKHyAG4NGL3P+14
 kaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777055246; x=1777660046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8fKE6uWynXvOQK+WQLf5kO4iqhFOCsKdnL+aW04mVOs=;
 b=rpcCYKus2RWFTXRXaV1qwcMN658Q+fc+lbpoasYMI2CFcvUWU3fVDjCQEqMCOlMOfb
 H26svVPoFZPP3MxV5LpXNpGKeuVHmn1BzPPZN11LE8hIq6Kcve+lxXSrQeFt2ouemars
 NdwV3e5auruSjoKzqiGvvjYkjJPgnl7SXjZJH4mTDjH2RPJoVLeGUavv3MkYs1KrkG1E
 +9Df5IIcUlu3wqtBOwCaGFPU1ERyfkSFxeCt5Zq3CwBhBNMtXpuhJ+3vx3XP+Z5aFwkq
 xRTmngDQi3kuweDakR54Xq50AVtE0ZKRQtGoE/+s9rdvhYdLD/VeO/AyMyr7/d43ntJS
 iJbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RjtyK2uSKGnmgfeioO6huLd56V55iGoxk4AceRw5NtpL4pg4WFQ3QyTqnHzul5fWhyHgsiBgHiNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPYbfbNpt5GtaDivMG7Xumu1hfds3OLGmGvkfilfmAAtkNBUOn
 DevWG44e5zdxWa5CvX2AIGkRTwoZ6kDX7ytrip/vT1hfJopHS5TsEfcys7TuMcvG63eYdA0v3Up
 eDHpdUACtbfuTs9+bMggi2XniU/90IDA=
X-Gm-Gg: AeBDietkYAe4R+U5BVdhJQ2XfYjOBsQdssxmYYtL8QTVYI30bn4Dgo70C+/THDzvzoI
 aLwBVOOX+i/xLnQ897X/ELGc58TPgwXga8SpvlIWTSUTO6A4Kw0Ar2/VJRgm+b5JstQDMyfwb1g
 ADtj5+VbUm4AYKBhJdgGj10INgsZbRmzNoSTpy3pd0UsIpJWEF1X84oETVlg1OkHKQaTv4d4jPO
 8yN2J3FGgqI4kNuj5CCi6kf1tNXKI5AuRLDhrK/ZJnAy0Tu0gg1ftayGDq0Er3/EYURMxisZqwJ
 fCPy5zhjA1s9+6WfSPTj27MC4IirBaLXwtIOamVDtcpc6WnpxyIShYL4pf0vOv75s3BiM/ac0M9
 MJh4r8J6Vuxju9ATotdeF3o/lGWnXqy9yZRaFeg==
X-Received: by 2002:a05:7022:383:b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-12c73fac0cbmr19164773c88.31.1777055245496; Fri, 24 Apr 2026
 11:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-15-f628543dfd14@ideasonboard.com>
 <CAOCHtYjJgqomKreDxLUiVbUtpeh36f0bL-jA6P-6rsoJrweshQ@mail.gmail.com>
 <cb19eafe-6c25-4a2a-bd31-9fb280837623@ideasonboard.com>
In-Reply-To: <cb19eafe-6c25-4a2a-bd31-9fb280837623@ideasonboard.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 24 Apr 2026 13:26:57 -0500
X-Gm-Features: AQROBzDdYR96fKz8FXyueV-T0huFl-SkTA_xyoSbvkzAGH098Vzr3EpRVRVzohg
Message-ID: <CAOCHtYgQ=71GtnUFkwhoVTkWma9rrbjp3xyKYUGVv1dG63m0Dw@mail.gmail.com>
Subject: Re: [PATCH 15/15] arm64: dts: ti: beagley-ai: Enable HDMI display and
 audio
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrei Aldea <andrei@ti.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Lee Jones <lee@kernel.org>, Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Andrew Davis <afd@ti.com>
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

On Fri, Apr 24, 2026 at 12:04=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 24/04/2026 19:16, Robert Nelson wrote:
> > On Mon, Apr 20, 2026 at 8:04=E2=80=AFAM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >> From: Andrew Davis <afd@ti.com>
> >>
> >> Enable HDMI support for BeagleY-AI platform. The display controller us=
ed is
> >> TIDSS and the HDMI bridge used is IT66122.
> >>
> >> Based on DT by: Robert Nelson <robertcnelson@gmail.com>
> >> Signed-off-by: Andrew Davis <afd@ti.com>
> >> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> >> [tomi.valkeinen: cosmetic fixes]
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >
> > Tested-by: Robert Nelson <robertcnelson@gmail.com>
> >
> > Thank you for getting the display back end working on j722s family!
> What displays did you test? I don't have OLDI panel...

I was buggin @Andrei Aldea to get you one. I also don't have the
'special' Lincoln tech display or the TI cloned panel that works on
OLDI..  Right now just HDMI as i decided to tackle cc33xx wifi again
today on mainline..


Regards,

--
Robert Nelson
https://rcn-ee.com/
