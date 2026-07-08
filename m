Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF0C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD9910E626;
	Wed,  8 Jul 2026 15:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNCMzsev";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNNeJX+Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F13289BA3
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:24:17 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C478l2760271
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 15:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=; b=KNCMzsevlh2tuc5/
 1WnIHZZhAhaywF9mfturWOYGVfOtDmek/uPAQGzO8pf5SVlIUqrprfq9VMbsxYYJ
 In4RT4IQuLvwHdCHl2uDDy4uroXw2M6EurBD8eSU3xR6PTtrM8Dmh59iWn6ws4dC
 92CbytmCMmFTb6lNx5rnJolDTaY4yGqklGGr7xsWt1VlIFJER6Uybv8uaGV5g0Ps
 rr0TV2ROBhLa1I2l3JKNmDMytA1jSAa1NTLNCifcU+9Wn7GCxMZBY2vQc0S+n/f/
 EYdNB5Cdm1Zocr9tW97T0cxeQ0WEWUd8uVX4VjqI0hpNRSjBJRCtoKTB03j6Z/Ki
 naEIwg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5w564-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:24:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f000e221d7so12512656d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:24:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524255; cv=none;
 d=google.com; s=arc-20260327;
 b=pu7Q2UH6Jpbh2u8jPY3tvk5p1ka+G1mzd7cgeDf8JmrLq4iL1Vna1GNngDJa0bMWrj
 9uysUzYEhckcdGxzK+giIO07MmVMaHIBdBcUkhuMDUZNQrav6UTNUXwc44/ypHdj+6Ut
 GdIE4pOsopy3kiJQMVpZYJqjTCo0R7QWqnAK4iI4Jr+k4dnTPBNCRKdHPrztAcMceJY2
 UM6aSHMhCc+gHcpu3W6rmdWVZiAQIaW3ThWOFhAppfQdM7cnhcGooKcPlR+IoDJ/5MNF
 t0RHmByoQs2KJxvxSevHYd7BZlJCxaaz+03lF4lakU4P06mylfPt2mVCYqOxfuZ5ABV/
 kTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
 fh=4EtWDP7KjGgF4K41U/HvssoI0tkej9fKdy/GlW9eglw=;
 b=bXCXmK2GDjhHKOTjkS6Y9g7bZjeSTyaRKBVzXNXh/mp7JadXNbnzWJ0T8HOWPGLzUl
 zolrQveB4t8cRpy4xJ2eAdHMmSCdAcPm4mRe0UQiOHZ1NJUVFzPJp6qhV4Lg5dlRbBgJ
 eNfhFqQAqoUFUxWxTHoZuNBzLwHRK2+DOhqflts079F1zVwSJfAH5AkFrt6GuCV138bj
 dlLloBvMW8wiGDISRFb9LVo2+XX7qmqVGVkwxBoSOKEZl1QDd8jsteh1A/AedAsprzaT
 NmENxFQb1rvmjiKPx8Kk9FKf5gRKGC9fizAD3kN+s52Hq96veyu6kqvtbhJ0VJa+X2no
 Nm8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783524255; x=1784129055;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
 b=ZNNeJX+ZYw7OyfNJqE/J/zdiV83WGz2Oew6fSaZdDHglZCakeNdMBIX1bNKfYH5Coj
 2E5xqjQiotRxZi/2quCKAvIKBFjaoUW8HlSluiB8y1qbPPRsKuDcgDR4MZHXzsxwRqdo
 7bh8LGHslxH2hbWc0ZpmaQTW7c7HGeNsD8dM0C2utqsefm9Mp+YIWszLjNeA3VjwN143
 AYFnOXAoZi2Rka7cYHZrjT7757UVrq9KFKxP2U6pys3rtPzV7rGpBOUqw374uq3eZKxG
 7lfDil9OVq2m3a4OY+dFDiV7y8Z3GPxYLjOxNypTPC9YEPJDrSKafQp8X7TCPehzdJKQ
 U8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524255; x=1784129055;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zMJCbXSgt5kAQ4lY2HA7hGLs+5rsBULHk8Vjj77tBIU=;
 b=PMhDvp9FyWpm+VKudVcZqJo5JjUFzLGmiz+ek7QtSnPzu2JysrXdX1FoNsIOy8FiXs
 IYDEjcsY6/FGIwntFzLHEKtEKGBa+giLirLIgABLso1STZXvhiyzytqzMdapvcUfxJen
 RE+SzkNLebnn2GpFKk1sJxI8oo3upWyvgGBXgDuX/TPafcGHOJlNeqBVlQJxFeURebm7
 Zr2s/hSCZcG7in+vLPjNgMFKGKsiJNySjYNNopUi4qLPI3PVhydsYSANFON/0U13X4JM
 ajJWjCCRnQYGxXZlGgkN7bF5KUsNZCZ8HQv0tQppXMhQPfmpzM2vql/UyRTrh43ow2mS
 D+Wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYq4ZztNAg/pGZfxI2c3616RNpy2gUb4fgGZqft0zT9wJIMSjEDEo0CusvCb+npNw916GVDYUMKTM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTwNyS4sjHqVjOFRL73hA7QXLoZC6IG1f+FGVc7p0/nLG1WNtD
 3ZZvRvTvJn6kshoPUo2/U2iUIJnlS2rpdxAXsL/k5vBvJmI6QHrZrgWPCr3rLPv89C1lOIm3jAp
 6ywmApd0+RBcDb6EoTn1AtenNI18JAr/+Qp4aBJaDIkxtbvpBAQD/PDZBIxlQibA7+Z38S2PHY7
 vfyTCwE4+h/Wy6Cfsw8UvhWbP18uspqCmJfodCYRXs3rC8Dw==
X-Gm-Gg: AfdE7clYbE3y16vaGUCBHb9H6QMj8Yga6zFkSI+lOoaDrcRmz8JfRbNPcMVJdOO3hdK
 fv5+6+JqbCSFMntB65Tq6XFesruIol9k3toGUwFdjoTcKiYlzq/3tDf8YkkeORxhN2cnmfYNhP/
 gQ9XpOOw3pax3+bNKzlALHnzQIwWQFA8H130u9hhU6NjQYt7N51pNnJbX8k+8UjW0ykrHP
X-Received: by 2002:a05:6214:5504:b0:8fd:6df3:b377 with SMTP id
 6a1803df08f44-8fec323e5b7mr31147516d6.59.1783524255419; 
 Wed, 08 Jul 2026 08:24:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5504:b0:8fd:6df3:b377 with SMTP id
 6a1803df08f44-8fec323e5b7mr31146966d6.59.1783524254959; Wed, 08 Jul 2026
 08:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260613070116.438906-1-midgy971@gmail.com>
 <20260613070116.438906-10-midgy971@gmail.com>
In-Reply-To: <20260613070116.438906-10-midgy971@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:24:04 +0200
X-Gm-Features: AVVi8Cct2pvQNJ49kCocOmZ_g-M7AfBNrJ0WxbavryIJprjGJGNLahRi4HQp2RE
Message-ID: <CAPx+jO_2=SYo0smYzwd8T+TUtHZtgXU0dSWQgZGZ_haV3aOU_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v4 9/9] pmdomain: rockchip: Add a regulator to the
 RK3568 NPU power domain
To: MidG971 <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xxm@rock-chips.com, chaoyi.chen@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, jonas@kwiboo.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: A9Ssh3_4UeuVXzjYW-_UKPQONZqbD9xk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfX+8D2+Gkt4e4I
 Urxsu5MillsKTqMcOEdwX0PprbQ7rrpxVfPbWeP2P2bEC/mr4yRYAq2ETgHsgVit4e4RccEMqR+
 kKozghyFla1ZZtjXzl6Ym0P2G7gvsjA=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4e6ba0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=s8YR1HE3AAAA:8
 a=bcpWyJPC7eKr9KdVfhAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: A9Ssh3_4UeuVXzjYW-_UKPQONZqbD9xk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1MSBTYWx0ZWRfXw0szcNpkI85z
 h4QgOJnxOloKjm9sXoN4SV2xmUsKZDweUWW7JWiz/0j+jkY94lCWneQnPALNrOuH3ac6d+smscr
 rSrDgvBSpJbfF3vQ2gocKInyP15KLD86S4iIsIm3E5Rz2mXy6RdDWdgaQXk8big9F2S+qhdlkwt
 cQBol2c67VdKFuBeJ6b2qiJ1AH/dTt0X2sLhdCZN5euQlnw+l36F5VjkReGlP3+0yZ+blF1l2cI
 d5usJH6hyPt6jVyZzxNRFe7+IkqAAJvCU4Uk8xWAnxa6IFUwqhf0UZFj5hEOWyrnC3Z5D+HmgjF
 hONJJc5n8ElLosWgYDH8hyWLTasUZjruhqxedrbG6bFuSwJQKNDRaQ2VsLW8AqGX05X7qNR7HFs
 vrTCMB1xgeHF/33CdnmcU0Ytab4j3cEhFnHprMy7bddQ9fkpFy3CjNi7IUyrOECZTX1yWUxxCNQ
 6rvdeNVwO7Q2JcdVpQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080151
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

On Sat, Jun 13, 2026 at 9:01=E2=80=AFAM MidG971 <midgy971@gmail.com> wrote:
>
> From: Midgy BALON <midgy971@gmail.com>
>
> The RK3568 NPU rail (vdd_npu) needs to be enabled before the domain is
> powered on and disabled after it is powered off. Give DOMAIN_RK3568 a
> regulator parameter (like DOMAIN_RK3588 already has) so the NPU domain
> can set need_regulator, letting genpd manage the rail wired up as the
> domain's domain-supply instead of marking it always-on in DT.
>
> Suggested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>

This looks good to me. I assume this can be picked up independently of
the other patches, whenever you decide to move forward from the RFC.
If not, please let me know.

Kind regards
Uffe

> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 36 ++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..19db307e3811d 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -138,6 +138,20 @@ struct rockchip_pmu {
>         .active_wakeup =3D wakeup,                        \
>  }
>
> +#define DOMAIN_M_R(_name, pwr, status, req, idle, ack, wakeup, regulator=
)      \
> +{                                                      \
> +       .name =3D _name,                          \
> +       .pwr_w_mask =3D (pwr) << 16,                      \
> +       .pwr_mask =3D (pwr),                              \
> +       .status_mask =3D (status),                        \
> +       .req_w_mask =3D (req) << 16,                      \
> +       .req_mask =3D (req),                              \
> +       .idle_mask =3D (idle),                            \
> +       .ack_mask =3D (ack),                              \
> +       .active_wakeup =3D wakeup,                        \
> +       .need_regulator =3D regulator,                    \
> +}
> +
>  #define DOMAIN_M_G(_name, pwr, status, req, idle, ack, g_mask, wakeup, k=
eepon) \
>  {                                                      \
>         .name =3D _name,                                  \
> @@ -241,8 +255,8 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3562(name, pwr, req, g_mask, mem, wakeup)             \
>         DOMAIN_M_G_SD(name, pwr, pwr, req, req, req, g_mask, mem, wakeup,=
 false)
>
> -#define DOMAIN_RK3568(name, pwr, req, wakeup)          \
> -       DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
> +#define DOMAIN_RK3568(name, pwr, req, wakeup, regulator)               \
> +       DOMAIN_M_R(name, pwr, pwr, req, req, req, wakeup, regulator)
>
>  #define DOMAIN_RK3576(name, p_offset, pwr, status, r_status, r_offset, r=
eq, idle, g_mask, wakeup)      \
>         DOMAIN_M_O_R_G(name, p_offset, pwr, status, 0, r_status, r_status=
, r_offset, req, idle, idle, g_mask, wakeup)
> @@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_p=
m_domains[] =3D {
>  };
>
>  static const struct rockchip_domain_info rk3568_pm_domains[] =3D {
> -       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false),
> -       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false),
> -       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false),
> -       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false),
> -       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false),
> -       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false),
> -       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false),
> -       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false),
> -       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false),
> +       [RK3568_PD_NPU]         =3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),=
  false, true),
> +       [RK3568_PD_GPU]         =3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),=
  false, false),
> +       [RK3568_PD_VI]          =3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),=
  false, false),
> +       [RK3568_PD_VO]          =3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),=
  false, false),
> +       [RK3568_PD_RGA]         =3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),=
  false, false),
> +       [RK3568_PD_VPU]         =3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),=
  false, false),
> +       [RK3568_PD_RKVDEC]      =3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),=
  false, false),
> +       [RK3568_PD_RKVENC]      =3D DOMAIN_RK3568("venc", BIT(3), BIT(7),=
  false, false),
> +       [RK3568_PD_PIPE]        =3D DOMAIN_RK3568("pipe", BIT(8), BIT(11)=
, false, false),
>  };
>
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> --
> 2.39.5
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
