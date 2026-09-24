Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598EEC98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B315310F586;
	Thu, 24 Sep 2026 13:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXNqTZaW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DQ/XgQ5X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E33810F586
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:45:11 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4Wu63134057
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=; b=OXNqTZaW1hVXUEuA
 RpbpIDZ5ZyZIMz5G3cp/uC/FgcuVeu3hcEkHU+lrs0zGQ9LslzczkcYpfSViC2pQ
 HDAj2sS5zlACKFUS3vuWUqwcHy/Pirw2f88NsGnJYR7H0RLWPSY9G/qjBuA7oVxg
 r7JUkZP6oRWhIYTIB6Dlxk0JYowYsovizQ5kDwCHxSzWKeHWGpUMjP2vryZbILNt
 p4jOnHT3okmy53j8LtMoyl+sGDCmTjkISbe/J+tNphd93NjcoU2TBMXKYrYszQ5t
 96fw3+VpQemov/UV82Yj085pC3Ts6ZG23ZZMYfL+KsMe2dJihm7aww+cvUEExwLZ
 /JxeBw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1ragvt2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:45:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2dd7d0751efso8516545ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790257510; cv=none;
 d=google.com; s=arc-20260327;
 b=YiOizsijFQFo7jdtx72pqB71IW8fUw2xEA36EiBNfpE8RPmoU7liOMo/Ezif2DYPez
 o4LuJFAp5Hd9CpJbbF3KPyF8mW0V6xtU4YNzBuiBjATNiVonmh0oNQSsZ16t2Hx4/yNB
 uwv2D21VIfLVk4f3abWGRG2u6pe8CwPXPjufdnHGOxAgQDMqVe0PCqXZIeT+i9MEmFW8
 IhK/hEgRcXbXlXlGeYBfW9YWSzkCWL93Ka6fJzk1G55KNy5Cg0eQO9a0Z2PYDUyLD1id
 Bqlfu08EdH7x/zT4mWJz6Gz9/sLJhZ+WFj92BZtUiVV9jHwemDxhfVAyad8rxKSQdyBU
 2ShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=;
 fh=xJwWx6VM6Hkn2BYiv4jYQ3B7jJdFDGg2yUgv9wDXymI=;
 b=spYJjN3acebKMXk+1xCRreHgeYntz7IRspz7MR9fJg5B4j73ZmF3BIvhNGV37jUnlq
 JVzwp/h3NPB7A3oXxvTEz8fibMjVFM+ZjZFX6pgoIUC/4hp11zv4vOERFChEEfBwM7nz
 g/uGzKNVftq30RFGbo6vIiH0EE+ZViQGVzQwbqeoezSVVbJuG4JF6TcM3ZnIkeDPnm34
 zgRScv52w7SFESJJySy3VKReLkbbhwafvgwpmjUt7mAgNvgCRAOyamfkGfQTrv7Oo2Xs
 ylZ2nv5w8Hw9lx6f/Fe44rY4kKG3a/IV+henPcZES/+wIz10Lysaun8KZwT7PjNT8RE9
 nRwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790257510; x=1790862310;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=;
 b=DQ/XgQ5Xu+S5xSEw0KfXtQXVMegpJG1M/FoTAT2NSWL1Gmd+gu/wDH2MLYZWT35LnJ
 9G3M1xKJqbB0LJ67WfYsgF89yETw5ZYoBFafx3vXby7GKaA5nhy7mBWCM+04a9/WwT5e
 FFX3zh8AX2qCwJw6eM2YXfmH6SAqSwjaqXglmWHiFAQ1ctdlH0wc0xKHfOPSWRNIyOM1
 +qdBkXur1ucb6jYVDDbP6rg990HOLbk3Edlnl7dbiMYqPx7/UvuukYW0DMzpxx5nhCZq
 CQVtt+M5TxB5fk/ZEILSwuxCwA7d96PiOQyFyGsQPbW97vvc6420xjQ93UfjJHaafUlV
 AGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257510; x=1790862310;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+92HIZiD8BjzLF20PEwnQGtt9JR2IY1fehiHqBhK2DE=;
 b=x5HvZf2EdABpcz/wJA22qoffZmCViALpAhi7coq19kTf4a32eGYDqb4hFPp1HX+Vxn
 iOJkDlWPkoxO7Q4krHMiA5CoNwtzddW6YzV2R7+Hz376pwEPiPyM1B1M0VQIpO/bQqP5
 53xSw3Hbs1vQxV0xUiQvogFm/dqeI+01sun2KaXOMFij00X41fGhTMF3k/SOGqBb78DB
 zvLUth3xpBkCNT5sZhhA6UgtuEJiHDfPDCEPFvqGPLhfy5WbMJqmmUViOJYIhrPdXfTx
 RY+dKkWrvw3SdgVFk3tNEGgp+QeT5oAvV8AukzQDab9bTSvyh+fXdN4TcRlj9sCuDQp9
 o5yg==
X-Forwarded-Encrypted: i=1;
 AKwUvByrxBYd8Skju9JdudMxhASQlbEFu9S6bNqM7AuKQHyUaUAH6rw7oj3qvjqJyXzHdJ4+1HcfL3w0Omo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lCOpwKzpaTexW2ZD3hoGWHQKto1YEVmysbSfxyVTJz68+Yo8Nd
 r/ZKuDMdsWF744sSTmYl7MktIujsXepJzagdZON8/a9gbnIGweCjnEi+UzAuuPXoBKbCrfcOWdi
 eiUWPbGexC28olSbo56CgV4iPouu+NkNBoQR/VE1kV5RbZpscDZvicrDYg4+rKP6nNSBiopbLXk
 20oCrrNsnwwYtnTUhLK8g0DMz4WWxEVAFJKwVPscaiTg9WVQ==
X-Gm-Gg: AYBFou1cCpt/ZL2C1p9DxiGc0Kth1OkWBE0MvozjfS/BLiFR33x93rf7mTzxd3E3xjb
 HeYq0cZYn/MmsXyYOmciiyMLiUgQyqIbIJdh0VFlq+kWOoua98rlRNtyjvZ+wrFXKRllz4HKgBr
 q5Ivbfc3ux62+94t2/qav9x/DHm9Mxzsz7Dtjxa9PRwin60B3sOadws08avg==
X-Received: by 2002:a17:902:e747:b0:2df:89ac:a9f3 with SMTP id
 d9443c01a7336-2df89acb234mr4396915ad.30.1790257509534; 
 Thu, 24 Sep 2026 06:45:09 -0700 (PDT)
X-Received: by 2002:a17:902:e747:b0:2df:89ac:a9f3 with SMTP id
 d9443c01a7336-2df89acb234mr4396605ad.30.1790257508990; Thu, 24 Sep 2026
 06:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 15:44:57 +0200
X-Gm-Features: AclHuK8823By2ir4rvAhJl6ftcMi5z7VMEo6jrXMBPTc2AtobSCQW7MLn1qCZ9I
Message-ID: <CAPx+jO-3aZXatF+zL=G_cG0QaSjjCPrdhpXOGZC+_zNYxjsP1w@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] pmdomain: st: ux500: Control DB8500 EPODs
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfXwnEWsX1CLBcT
 YMA+ovNDRI700j3KTUuyNM7fWP554v+3kDWDKRVM2KxX4kjLADa51+/7eE/Vyp5LFMPmbrmRvB7
 FWjucA2PVP04rEYq0eCmMNh1Hgkf813n3xo5vF+m9eNQnrTzDAR+sCBjoFkDPlzAeyU5qbJMdwP
 fykAKc50knbDAyghakN5nue2tUifkntBSYIhYQtTUR7zahEMZnxp3B1/2w6B/998aFxe4gADS/c
 u4Jnr2CbFgPdyVQSQzu52GDg2x6lhUscUbsdjX2h/THYu1Ob4iEI3+gJL3WfrH6TvYCSELw2kRx
 65rkLSiEorUWdKhbhSW4LAp0fFq8RSepO8qso9gMmg/EPzB5hwKH8tj7WFQ9L8+6GN/ZI6yCgEO
 L3x/t5p4Vu2TqPIk1B/BEwjtYp/GkEJ0PlDhuXD9FYyFZgbXpVLOjqHveT8oowT4TRhm5TA+RyL
 npq6ZBLEHE09pOnWDbg==
X-Proofpoint-ORIG-GUID: VIE5LPfmlQGsjeSIWQQ9Rp-Tn_zQN5S7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX3l3O3LJp/U3m
 Efm4RM08mMbWm6VComwWt/d6qzcEMsmduIOjpd4jw4vltPIB83eaGgJQzMUqmDMHsXaaci5gKO5
 wv6TsDOfKPBGcieiEP9iBGUmt/hlP/U=
X-Authority-Analysis: v=2.4 cv=fvpJ914f c=1 sm=1 tr=0 ts=6ab52966 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=-O4hDVTBhx9-GJANRbkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: VIE5LPfmlQGsjeSIWQQ9Rp-Tn_zQN5S7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240056
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

On Mon, Sep 21, 2026 at 12:49=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:
>
> Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
>
> Keep the old regulator driver mutually exclusive with the pmdomain driver=
.
>
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/mach-ux500/Kconfig               |   2 +-
>  drivers/pmdomain/st/ste-ux500-pm-domain.c | 355 +++++++++++++++++++++---=
------
>  drivers/regulator/Kconfig                 |   1 +
>  3 files changed, 254 insertions(+), 104 deletions(-)
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
> index d90a563cd6f3..b31a36a4acd1 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -6,174 +6,292 @@
>   *
>   * Implements PM domains using the generic PM domain for ux500.
>   */
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/printk.h>
> -#include <linux/slab.h>
>  #include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/db8500-prcmu.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/slab.h>
>
>  #include <dt-bindings/arm/ux500_pm_domains.h>
>
>  #define NR_DOMAINS             (DOMAIN_ESRAM_34 + 1)
> +#define UX500_EPOD_NONE                NUM_EPOD_ID
>
> -static int pd_power_off(struct generic_pm_domain *domain)
> +/**
> + * struct dbx500_powerdomain_info - dbx500 power domain information
> + * @genpd: generic power domain
> + * @epod_id: id for EPOD (power domain)
> + * @is_ramret: RAM retention switch for EPOD (power domain)
> + */
> +struct dbx500_powerdomain_info {
> +       struct generic_pm_domain genpd;
> +       u16 epod_id;
> +       bool is_ramret;

This one is unused for the defined power domains. Is the plan to add
support for this on top, later on?

> +};
> +
> +static DEFINE_MUTEX(ux500_pd_lock);
> +static bool epod_on[NUM_EPOD_ID];
> +static bool epod_ramret[NUM_EPOD_ID];
> +
> +static int enable_epod(u16 epod_id, bool ramret)
>  {
> -       /*
> -        * Handle the gating of the PM domain regulator here.
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
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_RAMRET);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D true;
> +       } else {
> +               ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE_ON);
> +               if (ret < 0)
> +                       return ret;
> +               epod_on[epod_id] =3D true;
> +       }
> +
>         return 0;
>  }
>
> -static int pd_power_on(struct generic_pm_domain *domain)
> +static int disable_epod(u16 epod_id, bool ramret)
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
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D false;
> +       } else {
> +               if (epod_ramret[epod_id]) {
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_RAMRET);
> +                       if (ret < 0)
> +                               return ret;
> +               } else {
> +                       ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE=
_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_on[epod_id] =3D false;
> +       }
> +
>         return 0;
>  }
>
> +
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
> +
> +       return ret;
> +}
> +
>  /*
>   * Apart from these voltage domains there is also VSAFE which is always
>   * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
>   */
> -static struct generic_pm_domain ux500_pm_domain_vape =3D {
> +static struct dbx500_powerdomain_info ux500_pm_domain_vape =3D {
>         /* Vape_pwr */
> -       .name =3D "VAPE",  /* 0.95 .. 1.20 V */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +       .genpd =3D {
> +               .name =3D "VAPE",  /* 0.95 .. 1.20 V */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,

Several power domains below share this epod_id. What does that really
mean? Or is this only temporary?

>  };
>
> -static struct generic_pm_domain ux500_pm_domain_varm =3D {
> -       .name =3D "VARM",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_varm =3D {
> +       .genpd =3D {
> +               .name =3D "VARM",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vmodem =3D {
> -       .name =3D "VMODEM",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vmodem =3D {
> +       .genpd =3D {
> +               .name =3D "VMODEM",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vpll =3D {
> -       .name =3D "VPLL", /* 1.8 V */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vpll =3D {
> +       .genpd =3D {
> +               .name =3D "VPLL", /* 1.8 V */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
>  /*
>   * CHECKME: as these are used directly by peripherals as regulators,
>   * perhaps they should stay in the regulator subsystem?
>   */
> -static struct generic_pm_domain ux500_pm_domain_vsmps1 =3D {
> -       .name =3D "VSMPS1", /* Also called VIO (1.2V) */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vsmps1 =3D {
> +       .genpd =3D {
> +               .name =3D "VSMPS1", /* Also called VIO (1.2V) */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vsmps2 =3D {
> -       .name =3D "VSMPS2", /* Also called VIO (1.8V) */
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vsmps2 =3D {
> +       .genpd =3D {
> +               .name =3D "VSMPS2", /* Also called VIO (1.8V) */
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vsmps3 =3D {
> -       .name =3D "VSMPS3",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vsmps3 =3D {
> +       .genpd =3D {
> +               .name =3D "VSMPS3",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };
>
> -static struct generic_pm_domain ux500_pm_domain_vrf1 =3D {
> -       .name =3D "VRF1",
> -       .power_off =3D pd_power_off,
> -       .power_on =3D pd_power_on,
> +static struct dbx500_powerdomain_info ux500_pm_domain_vrf1 =3D {
> +       .genpd =3D {
> +               .name =3D "VRF1",
> +               .power_off =3D pd_power_off,
> +               .power_on =3D pd_power_on,
> +       },
> +       .epod_id =3D UX500_EPOD_NONE,
>  };

[...]

Kind regards
Uffe
