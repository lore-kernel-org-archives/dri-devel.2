Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD14CD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1AB610FB57;
	Wed,  3 Jun 2026 10:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RV/ZBQBW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="StZUOYT0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B1210FB56
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 10:15:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6536RS6S1946589
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 10:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=; b=RV/ZBQBW1Gz7WB7g
 C36gOhNhdL+lLAmqQlpap6noJbbxHcrt5EIxi83XQdvwRajDeMt1YFcY+H3mGLXT
 9XatmhW6r/yTEhIszMkIGbMkNaO+fyhhVMzwIGL7bcpZ9ReeDX5jEpLuRbcstKSQ
 YhnhXEg7Vp0lJ0rPhBLgdWq78t4NPOsw/LugKMhQPSnThw01mcIgA9my3R2A/CFD
 SMxSsEToum0RhiBvscPxkFsFs1FxqjfwWOQrc5lvshnJbrHXt0WtI8psq0P5nZyX
 LEs1LzosAOE89oi/Bezr5wGe+ccK2iGDRjqfsqOH5hQOImzaSe/nMOk3SRXe02I+
 vbBXAg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabghxhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 10:15:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so84536696d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 03:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780481735; cv=none;
 d=google.com; s=arc-20240605;
 b=Yx+mw5jA4m3CnMTeWK88h8zSKK5Oyzx2BzGoSNirhKAZSuX6IycDe4Iarq0Uet4LMF
 8JXxOrcBMGnEceRoyuJa5rLXeP6KVIjY5SWo4pkFkBQZZ3002KTZLDJDFPCUe1LtG5wz
 jBLcdkrIQs1+TamNDE6o63psMSAtwY9S08Pw7DbirG8I2JOZpxAzSfRm62qqfRR+xcBP
 ZX5cuYzoXFRJfBJiAXikQ4jEHH3jF5XnLA485R0b3fLaZ5Ife9KBqIXDlP1v0F8eTr5b
 qq+QMeK6JeqxgTO1ZpGPYlIje+MfsUrDnuhFXO8jgzTqE4sOusRwvMyeuzpFACc8yKEm
 Hqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
 fh=0/GWQMsyPJE4qLspbikNKBmzgfY33+23JxK67KOlmN8=;
 b=V7P4zlY16RdvrNV9MCD7YVojqzgixMS9GoPQ89Xo3GK12TmzM+9I0D5XlITV7VmJ7m
 4t3dtfvQCAdS/+tTkFInWUc/sQuRi/AeI+Lmp0DN5os7Dib8ygXbf/kRxM8uonidSs69
 kl8qJv7NwWzoLamcGGeU+qcVk9mFC5jKOi25PTL7I49+0PZIyC6pKYwnbz8axH9yfJJh
 XwRY0HlKSQlQhW9Oryo1uaOstqOHT5k4k+Qsm2uO97XIQErE69RbgtTsCqtgFo0D1I/p
 XY8KLepKVY8hjpOz8PYr4iFLSu9QP8OmnVbGt5Kc91GfnQZ3DoiDBBBugvCHwGh/XGqy
 QCxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780481735; x=1781086535;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
 b=StZUOYT0gM4ZEEzMg20VejLdytgKo+KvuXrY/fzp60cBqzwhIwm2dxGOO+xh/YsgR2
 5ztHBMAmShUlQolvRjdL/ZEYtFQDxAWQNjA7oEibww9BjhtzqMJIT42+rb7Ma4AAtmMT
 5YkyiS0zBHnkI8KFsKdqcaApoxsFnuMXkKJAG3J7JcloP8ZIQZjEkQFtvuvly3YJqsR2
 P33Mea+BiuPLyJMTLPMJLyDdduLEnXDbj3SWviJ5mgv5a8zHVmi2EiqTCzkdajNmE65K
 6Ot1c+odBVcXVeaMHBHOrQElHMnyAQmG22DQHIzhqAKJbPPssfwapCgYo4nyLMEOh6kz
 hdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780481735; x=1781086535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9n9AHlZU6kUO1j38Uc9X0HmM7AR04hZBNstxafGjgo4=;
 b=kGVYtZ0qGdN7+blYkvEPMsgDtB1PIaWG9Ea5BiDT6hAYa9yevCHjCDOjG1QtywNA4s
 wJJVo5ERodSapB6TkpH3tJe7QkHu2lPQVQvC7xii985GcE9ToMMKqOo8RuD7F54OH8mA
 7NIfix7HNpWAN99n6VWBNgW7bmgMh5nc0x1ULmNrmIGb5Kg4S919zExpmDuyZXTOnfkn
 yaMZj+meysKdn8uW453/jiwtBJhUoAJsWOPnvt6HhkTP2ApxXikrRTir5ixinHLMApLz
 uatBangfmzsGwNH/etG0FcuLHObacMnsDRJLA2YhpIe4q4O6AhBNxvGHZP0mlVODeTJp
 QnRw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mqK2/RGWQhZDHuGizSb9ZEjypvGxL20GmvUarFuPaJv4KyMAkMosNoWbFNh3xOa4gauqYOYR7fbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWlSGALDpYrBHX9MvIja0dCrRCHhtlmtkjHxSGdOxBhSci3VNk
 eUbNscFx8I3lywLwu0ee/bMm7tw57hMH5Ck6p1qzX5P2RkstGjxTdH8WL16GqjBDdW+qVQCEI/K
 puy2OMi0ofyY2QO+z8D60fz17pd0ogiVW+n/8X0e5Agdq3PnVvr42VPR59gwZf/80Q+lprCWivx
 Zw6yYZOpMtenye55SF/I2VHKnzmGy8wyCcaKdg0PUphXdiUg==
X-Gm-Gg: Acq92OHvFyIty78S2l7SUx0SpSFDbZlBm9UczV1MQYMpWwTguomQMnatalcVJfnMolY
 plcRwCPq9ESkSPg/JUrqFcD3gmGVFbRr5egHeMMX9aNd6EeSi66VmJVwM2BnpAeehXnGvwRzM6D
 9E5HtMjFhPnDA81udIfokNQywxl9UvvzVerzZGLqGkk3alL+3JT2NcWL8h7Rnloi7tV3Dq0Vz1p
 qdzOH+Al/f9mB3y
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cecdc03682mr27952086d6.9.1780481734754; 
 Wed, 03 Jun 2026 03:15:34 -0700 (PDT)
X-Received: by 2002:ad4:4984:0:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cecdc03682mr27951226d6.9.1780481734358; Wed, 03 Jun 2026
 03:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-4-88c324a1b8d2@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 12:15:23 +0200
X-Gm-Features: AVHnY4J4K5UzPNs1yW8q3X0LoIQq3c8UfPuD4kHDjf5PzjApCRf1PSF1rlsmtoU
Message-ID: <CAPx+jO9iJBx6Yifap55NOhn5YZk8Bbwpnk+aeH+0PgYuMxke1Q@mail.gmail.com>
Subject: Re: [PATCH 04/23] pmdomain: imx: fix OF node refcount
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Peter Chen <peter.chen@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a1ffec7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: K_wZnSevknSxrflDJsvB2YPtArBceCTE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5NyBTYWx0ZWRfX5Ac0w/roktV1
 c5fCxS1Q4q+ItOF5KBgcpbbnT6tVKmWLsc9vJlVN1j1/77tAZW4oHTh3j6thKZDh4KMGUCXcxuJ
 Q7coRumqESbt1UoSH3nrzpmyqUTT/6Y7/tqVBZAHwbAZMjX4vPM0LTHuXASFN0zD0QnkxJG+EHy
 mROQj+Og72gL5rWIVgEiJoJnEKqWRquD38OS1nR4GxG/5e4EcDA7a5ViuMxvRDdOgL0FUKcmrak
 4AxOD/xuCwylojp2heFeCN6Fduqfzws8D1MTTuhZ6b4VX1mE1AVs9bie4hhyaLDujJ+2ktvYoTM
 94FwFU6MPE7HFcxHIriZx1Z5fcXkEcZX3Re6u73GeYayau2woJQOJVIKuI4Gcove7u8BIhZbxHt
 oatqeqoYDlbH5PcDt+kOXDSc0a/R5Rt19FMLzkC2DaB3kEYYF3QCZTs3yrBE/3FvNv7M/k/6USE
 3RRTsmmEVOBYLpGGgQQ==
X-Proofpoint-ORIG-GUID: K_wZnSevknSxrflDJsvB2YPtArBceCTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030097
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

On Thu, May 21, 2026 at 10:36=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> for_each_child_of_node_scoped() decrements the reference count of the
> nod after each iteration. Assigning it without incrementing the refcount
> to a dynamically allocated platform device will result in a double put
> in platform_device_release(). Add the missing call to of_node_get().
>
> Cc: stable@vger.kernel.org
> Fixes: 3e4d109ee8fc ("pmdomain: imx: gpc: Simplify with scoped for each O=
F child loop")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index de695f1944ab31de3d37ce8000d0c577579d64f9..42e50c9b4fb9ffb96a20a462d=
4eb5168942a893c 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       pd_pdev->dev.of_node =3D np;
> +                       pd_pdev->dev.of_node =3D of_node_get(np);
>                         pd_pdev->dev.fwnode =3D of_fwnode_handle(np);
>
>                         ret =3D platform_device_add(pd_pdev);
>
> --
> 2.47.3
