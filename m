Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1239C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C3E10F1B2;
	Wed,  8 Jul 2026 15:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gpi7Z0iH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJva3y4N";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4677510F189
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:43:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668D7uqA2678347
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 15:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=; b=Gpi7Z0iHanVc4ewT
 7FQ/iOmgIDYfQPNsLWBPahVUdstaYgfQlDtGjG8VdQQA7J4awDImmOUNWK7vXyEM
 tSCOlLcy4XHryPydn5GaRVu0CuNO/LMFBPRrPiUtLOo8SoV/IcsywNpNveG3cn6g
 VDgjqyDZIdd4vgQqIb9ZYLZc55+qR8tBPSNrjrvHWDGsX/3Tk3aD30L/o2F4t6w2
 zphI+wMiWRJYxTClL0K5W1KWq+cUBGielBfTLp041HPpIH7eneORQez1UM2tN+J/
 M9UK/hSLMSNSRYjxhJwXnpci8Kuk8ap5IbJmXjvS3+m3abiBsrAgD6FN7RfdohoZ
 qd31EQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s8r8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:43:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so17099741cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525408; cv=none;
 d=google.com; s=arc-20260327;
 b=eqUW6+A11bPJqgHpfPhv5Em0h2ExqUOO4qHJtUSuyxdj2AGOUjU4nTx7mv6gTC0Q0K
 o+VpEwOr8d4JAQnRQgvSTtMTUM0kWPRitCP1OeBfCvbb2hImJALiwjBwy6k2fHzGU513
 4ZEWEiBwZmfN6/QC5gI8A2y3alTRB6+zTLyLd0XM1yOnBsicmiMtexMUY/gvzFMQvAWr
 Saq208E2xImRnAmldXVVeX/TQTs1U6OtY1c3xRbf0XQK6YahqR1l9VWzV38MkbJ8ps+F
 ybYP79uZXX2gw95IoLPlIgfAFyqMcnVYZ7jUldgLczd+DFp0SauhPtw1bJ09uJJmVbEK
 9Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
 fh=xqkNvh1FTzO4s6LjBbHkmInAAbGUU2YNgOmmRun/7p4=;
 b=akseNGzWg+26nKG2VJ6eGNFeLHrrBTRhnGwzlv2vdDbCVG89D0fJrV4whXLXG8PhdB
 1DbLOy4C6sf2u5re6hgkml5/ILbFJgyKnBtf87MqCm4vqvg8mIoxKHG6umcA/0cS7TaZ
 5CACKD45z6Ix/zv1dSA1ulOiT3s7fbUzlOW1iC5AxwHYNtJnWIMTOIqyCBe+9ESZXIV/
 eBVYQ2RdOrnHmfRg6iM2uGTKPLqDCdPvCv0GkytIfOmuftlNKeQqq2oQqzf3SJkH/62Q
 3D27mRKksbxo+WxW7IWPA3bs/zDIeCKfWMrgag8Q1zXXiXbslLy8ApWRvtrrlZeubYFl
 Rx+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783525408; x=1784130208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
 b=WJva3y4N53LEvXcDiVtIU63hSHY4lDR+AJiLntDKjAB3w89QUcLheJphib3ohnPpYO
 S2eb0vE3mqolC1XdWxgmlW8grc4KLOwm18lkZprF4tgHlTiKkz7lMxLplB9BcAVMoPI2
 fqZs6LdxS/hKnB0Q5Hhdpyho0MQKnPd+deYcd3VLwhvX0Bg+y3JbF3TfQ09Z/nvjXe4E
 w5IQkkbadh/zj6CgWfZai2rrCFfjAW6T/BlVIv0tcwAv+HSigpD8kJrNZ99vfXw6z2jp
 3UGeDxzNSilRKTLdhhtwNKwZX2C8t59aDtth+4YQ4ItoZpfEa+Qa7tR/ysKqEbmDIebT
 z/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525408; x=1784130208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
 b=Spb6s1vttGj2ur7wIJ6pqxXonKsgDkpiNXGmV9Q4EWkS/vdcKgE9QthEExlw0LbgL0
 4pPvwIon/tb9TKMDFep88IMKz7OqINxm0SMf2fZ8nvuLUWoWghoTiyaY0DyBe3p8K1Tr
 /EKvvZMkzyuoQmmZJL2kB/BRb/fqkqSwSMQ/08SxbQ6vFSIvfV96dD+yMCJC1D4G/Kqr
 qnXoQtckdv+qvjzi8UVrUnqK0zxUk2JfA8YUqcbrHj1zAhMq2lAqK6WhY7je42ojaMcP
 5Q69YQxI9WdWi6xcZZ+g6Xd/8djyplK9OTdSfeWe4YH7s/VYoth5w11AlCvGc1JSkuWC
 keLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4mp6E1S7emwJG4xA8+svlTiuguXuwyQ/SsT/MCoWNc18XcgRGAhhGnHjv8IbraSktCHM5xIV1Pms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAKE79ucqaOMztujv93zO0UBbyfU+HzPCZ0/g9GVaNIgjY/HBo
 mbueTJk02XSxq8264exHYD54OL6i8qAXSpeV8k2LiAVzbvjmhSw/EULBpaJzEnb0Ci4shknun9v
 qeoPR48wL9CqXzdE4sV9doe19uft2EXIMdjyA9wWjSGBC60qq0ga2qML+Vn8KNzzb+qwfehXCaB
 cuq0Sd8aamBTCVH123h7sXLPW7/ONnv3+XQgTVpVzX3/DQjw==
X-Gm-Gg: AfdE7cmyI9FO2F/ObyKNSL/aZ/h/I18ssMrc4pEY7i4b638pTnvUq/l2L8B/Yrw5zMQ
 S4SS10GyYyUiiCQrMqTtjmK/HIOmS9T8QBDRq1bnLjKf2g1LiVYAjct/kmmAiogXYTDqOk/RMGi
 YjRYnidwMjgYHxnKGYyg9O2aMadfcv65TTQjxHnKUvzR3dP8k3ln/Z/8aroX445f1FNk02
X-Received: by 2002:a05:622a:4c05:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-51c8b398897mr31022821cf.11.1783525406241; 
 Wed, 08 Jul 2026 08:43:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4c05:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-51c8b398897mr31022071cf.11.1783525405268; Wed, 08 Jul 2026
 08:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:43:14 +0200
X-Gm-Features: AVVi8Cdq0rtjAP0YSg4WhxzCqmLPP1um1vAPUHWXvoo9MmpPquQaWcjqsUHRPk4
Message-ID: <CAPx+jO-teiu9vQfw+MeTbixH4PnARaqSC+_7bvHUMAAEPqtDaQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] pmdomain: st: ux500: Control DB8500 EPODs
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfX3jyn88Dr1Fe1
 T8ytjWW59YlSeoOCrtRl1sbMG/7j33DhGwsYIi7o1R7tvMFcgUEg5IX/ud3OFUEbLD6qdjiQOJj
 X135z+xeKxz1p0ZmDdLlpuC4DXFxQ941Nn1KHAUleOkluX/SAYb68OsOcdeKtjWhoIMcGMSDuXl
 Jvl6TXWIccbw6UMMxcX03F04qwHwtlYTar9JXBYFvBvFn/Xv+GRa1KPicWP6NCvkj1GhrK5GeTX
 5Q48a+/aUeBYQ63AH1WUqK1ZilklRwuaQSVBV0Mm859qmv8vW7lg1uvMpn8l/CcNYkIUtn7PBnc
 hQZvDGr0hD6F73Zv659B2t4imaQNYHlOdNWA/qqy6g2H9bAD/r4QmcGQSpszT3tyCTpQSDdmtsk
 8VgnCDy5QykPDCg7EY/60V+LcJh8csvMZE+xHUMbYrd2aS+t1JMDId95oDpvSMtSV9N9Ke10Al6
 towd3okHEZbuD9plK0A==
X-Proofpoint-ORIG-GUID: AlV5N8nqBTo0uQuXTeMv3p0Gv0X9qGCX
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e7020 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=-O4hDVTBhx9-GJANRbkA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfX5q6IqaLRej5d
 ttvStip8OdhRyHh33YrLAD2tgC881YQDwG2ZiOJ49M7KqBH/txjvWtFX/HCpGyB7C3oU/OPTmvO
 wvaKXEDnCFFg/MAbJCJRQQeouKi04Sk=
X-Proofpoint-GUID: AlV5N8nqBTo0uQuXTeMv3p0Gv0X9qGCX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080155
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

On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
>
> Keep the old regulator driver mutually exclusive with the pmdomain driver=
.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/mach-ux500/Kconfig               |   2 +-
>  drivers/pmdomain/st/ste-ux500-pm-domain.c | 380 ++++++++++++++++++++++--=
------
>  drivers/regulator/Kconfig                 |   1 +
>  3 files changed, 282 insertions(+), 101 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index c18def269137..56636c993f49 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -26,7 +26,7 @@ menuconfig ARCH_U8500
>         select PL310_ERRATA_753970 if CACHE_L2X0
>         select PM_GENERIC_DOMAINS if PM
>         select REGULATOR
> -       select REGULATOR_DB8500_PRCMU
> +       select UX500_PM_DOMAIN
>         select REGULATOR_FIXED_VOLTAGE
>         select SOC_BUS
>         select RESET_CONTROLLER
> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> index 723001004690..1cd5b4985db0 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -6,172 +6,315 @@
>   *
>   * Implements PM domains using the generic PM domain for ux500.
>   */
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/dbx500-prcmu.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> -#include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/pm_domain.h>
>
>  #include <dt-bindings/arm/ux500_pm_domains.h>
>
> -static int pd_power_off(struct generic_pm_domain *domain)
> +#define UX500_EPOD_NONE                NUM_EPOD_ID
> +
> +/**
> + * struct dbx500_powerdomain_info - dbx500 power domain information
> + * @genpd: generic power domain
> + * @epod_id: id for EPOD (power domain)
> + * @is_ramret: RAM retention switch for EPOD (power domain)
> + * @exclude_from_power_state: exclude domain from power state count
> + */
> +struct dbx500_powerdomain_info {
> +       struct generic_pm_domain genpd;
> +       u16 epod_id;
> +       bool is_ramret;
> +       bool exclude_from_power_state;
> +};
> +
> +static DEFINE_MUTEX(ux500_pd_lock);
> +static int power_state_active_cnt;
> +static bool epod_on[NUM_EPOD_ID];
> +static bool epod_ramret[NUM_EPOD_ID];
> +
> +static void power_state_active_enable(void)
> +{
> +       power_state_active_cnt++;
> +}
> +
> +static int power_state_active_disable(void)
>  {
> -       /*
> -        * Handle the gating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       if (power_state_active_cnt <=3D 0) {
> +               pr_err("power state: unbalanced enable/disable calls\n");
> +               return -EINVAL;
> +       }
> +
> +       power_state_active_cnt--;

The whole power_state_active_cnt thing seems to be a leftover from
debug exercise, no?

At least, I can't see that it actually adds much - or maybe following
patches makes use of it somehow?

>         return 0;
>  }
>
> -static int pd_power_on(struct generic_pm_domain *domain)
> +static int enable_epod(u16 epod_id, bool ramret)
>  {
> -       /*
> -        * Handle the ungating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET=
);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D true;
> +       } else {
> +               ret =3D prcmu_set_epod(epod_id, EPOD_STATE_ON);
> +               if (ret < 0)
> +                       return ret;
> +               epod_on[epod_id] =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int disable_epod(u16 epod_id, bool ramret)
> +{
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D false;
> +       } else {
> +               if (epod_ramret[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET=
);
> +                       if (ret < 0)
> +                               return ret;
> +               } else {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_on[epod_id] =3D false;
> +       }
> +
>         return 0;
>  }
>
> +static int pd_power_off(struct generic_pm_domain *domain)
> +{
> +       struct dbx500_powerdomain_info *info =3D
> +               container_of(domain, struct dbx500_powerdomain_info, genp=
d);
> +       int ret =3D 0;
> +
> +       guard(mutex)(&ux500_pd_lock);
> +       if (info->epod_id < NUM_EPOD_ID)
> +               ret =3D disable_epod(info->epod_id, info->is_ramret);
> +       else if (!info->exclude_from_power_state)
> +               ret =3D power_state_active_disable();
> +
> +       return ret;
> +}
> +
> +static int pd_power_on(struct generic_pm_domain *domain)
> +{
> +       struct dbx500_powerdomain_info *info =3D
> +               container_of(domain, struct dbx500_powerdomain_info, genp=
d);
> +       int ret =3D 0;
> +
> +       guard(mutex)(&ux500_pd_lock);
> +       if (info->epod_id < NUM_EPOD_ID)
> +               ret =3D enable_epod(info->epod_id, info->is_ramret);
> +       else if (!info->exclude_from_power_state)
> +               power_state_active_enable();
> +
> +       return ret;
> +}

[...]

>
> +static int ux500_pm_domain_add_subdomain(struct generic_pm_domain *domai=
n)
> +{
> +       return pm_genpd_add_subdomain(&ux500_pm_domain_vape.genpd, domain=
);
> +}
> +
> +static int ux500_pm_domains_add_subdomains(void)
> +{
> +       int ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_mmdsp.=
genpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_pipe.g=
enpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_mmdsp.=
genpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_pipe.g=
enpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sga.genpd)=
;
> +       if (ret)
> +               return ret;
> +
> +       return ux500_pm_domain_add_subdomain(&ux500_pm_domain_b2r2_mcde.g=
enpd);
> +}

We recently added a generic "power-domains-child-ids" DT property,
that allows us to describe child power-domains for these kinds of
cases.

Moreover, we have of_genpd_add|remove_child_ids() to easily hook them
up when probing. I suggest we use that here as well.

> +
>  static int ux500_pm_domains_probe(struct platform_device *pdev)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
>         struct genpd_onecell_data *genpd_data;
>         int i;
> +       int ret;
>
>         if (!np)
>                 return -ENODEV;
> @@ -196,7 +372,11 @@ static int ux500_pm_domains_probe(struct platform_de=
vice *pdev)
>         genpd_data->num_domains =3D ARRAY_SIZE(ux500_pm_domains);
>
>         for (i =3D 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -               pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +               pm_genpd_init(ux500_pm_domains[i], NULL, true);
> +
> +       ret =3D ux500_pm_domains_add_subdomains();
> +       if (ret)
> +               return ret;
>
>         of_genpd_add_provider_onecell(np, genpd_data);
>         return 0;
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 87554ab92801..35d1b191462c 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -414,6 +414,7 @@ config REGULATOR_DBX500_PRCMU
>  config REGULATOR_DB8500_PRCMU
>         bool "ST-Ericsson DB8500 Voltage Domain Regulators"
>         depends on MFD_DB8500_PRCMU
> +       depends on !UX500_PM_DOMAIN
>         select REGULATOR_DBX500_PRCMU
>         help
>           This driver supports the voltage domain regulators controlled b=
y the
>
> --
> 2.54.0
>

Kind regards
Uffe
