Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B8606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nb75Bhnk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=beJ1jBOo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E9510E2B6;
	Thu, 26 Nov 2026 12:04:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2105C10E2B6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:04:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQBVSbW2785123
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=; b=Nb75BhnkD+24lshd
 TN3D1/aSnF7vHIpkHWwHrM1kKC6YkQu6oDHCxehUDM21hbKbjJyKXraJpSLvlXam
 gnP48d6B48IUH8DyGbf9NtPmsHJPfx1s+Xvo5g4i/6YSn7IKpv0RiuFj1u1B9HCJ
 nrsS14m61D4eNFRt/O9DQMyuIHBNkyiU42V3jRVb+6Xe3JU1uiB2RiZqWOkGZ5t3
 rUyoTCQJYk9dWVXIeVjI5rchYL8/hXkY9Ti0nM78XMS0H/uKHppIWpJQhPXEUnny
 GUDcDdJMJSAEmIBUWh+5vuzpXWLnzh/Y4mOkufX6bT7G9X80VxDZf+8DGg53esvd
 P3Nrtg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j66qfau4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:04:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3b4139b7abcso6138803a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 04:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795694668; cv=none;
 d=google.com; s=arc-20260327;
 b=K/Zl2dtxmsnYj2EmKm8ohZPItIp3EzbMOIDFP+1xUqCAghbSY6NUTAFcjgForsuF3N
 1G5gJdCg51Vn+FUHRTxreOBHjnzRJHDd1CxNT7BBEnozSCqX3AnyajGyAAf1jW8wApcQ
 obQ2hKhUYnFaTrxdDzUNhf5FyMxDRW37eMkd3XOzxPH5BSES/U9l13PRSYZgoE1wqAi3
 mn4QVYl8C28N+OG5gpTkm5CBlOAXLKvXIDQarfjGXoIt4lr4dRQDj9u2yofH6pWRivRy
 abpLTBoI3sIlJKG/8MgXSGNLvsdAbmS1DfNGkHbmuIkiImWGKvGTmdzf54Jb3xYsxBHX
 QeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
 fh=g68L7Sy8BFqODsmWLOrN5yYr8Cf99g7dKpQZx5iWRLc=;
 b=oSj12lWLJpXNCMBECJF3CPHCLhG1ae8Aszof0k+l7KJnZi/SMvKVUA3BR19dNfJVvg
 4ejz9iNXDLbFvUkAbG+NI9obQm8v6fPM+pfhCnbyZaxSQpUXL1bnA6jkUOqnV81WROfZ
 BHNUEDxDC8GdAm/xIEo7ElVxL9Ga59jfawgnRNNbtVHp7uPuN73mhy7YcIVsaJX44pXN
 93zaOjqtnt5Ls8UbpAf4dKRBVeTCBHDBLkyVLo4JHm8JC3JYQ/KeJyJZZGbHXERm81Fd
 WhKGqmRA3oOaoDRHo3u2V4wu5zaWJkp7DsZl/kXEFbvEZahBt6Y49eJCPM63NmoKCJEZ
 sFaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795694668; x=1796299468;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
 b=beJ1jBOomWSAM30Z6d77ranI3PWrOY17jjRyRoSdkpA2c/xHbLOfV29I/zBgnJO2ws
 QGLxibjvcbCkuJ1jwNhaMQK7Tf26GwO3Ohjf1FwKDkn4RBa09F/nufU7C60+36hyIy/k
 w/aa+3bfOBOfwb+XM6ovWQtrVPK2LnqkP29EbDdGIbeXo9r38Ohg0ZOPDSAaYODCKtDn
 V48ytNWFtn6grAW/C0yjgLrByEF6tx/wQ7XBiN/y/cdfB0pkmFMEs4EuMrlNBPdMSWj7
 rPugXQFI95gQLaVqydo6O3Rxc14W1WIuZgNdOSHv41HaPq4qncwoWbR6xMc/5Uyp8vwS
 L5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795694668; x=1796299468;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jC5fbmrjeahgJSQY/yuWAzz2qq3dYpFpTS3cMwzVOs8=;
 b=KuUhra5Zns1p5/1lleed4PZUnoGIKT6QQy+KBhne5WHxUxanKPzM+U2BhMzBT/4rss
 zzqIgCGW82cqso2qZEvKGSXi9H+JJRuoIocjobWcbhI28j4GpxX6lHh92J6b8fq4U/9J
 KzdkUHvq+OxM2aHks09AkmvT2Z5SbqI29SMJ+2zFYsfs54//I5Mi3upVIftG3kdd4ZQ4
 aHqdWwUGp4XBw3RAW+dmMgakWHPFiAsW0NGED0mL6tWNk3T+FlZ1ODSwxdhkATY8GRiD
 bXnQnxaSyp7IK9yTsLLOEZ41Oh/eSf7vVmkthqiatdIUep81tBb8DPmiSjMaEUwzaSxd
 cQ2g==
X-Forwarded-Encrypted: i=1;
 AL+hErEIWiKa1RQhc7g0emA+5LM5/uBobSawwM2/nktuOeq5ahGcn/jLaRLMC+PAW5NYcPTkMvWOo7ZRZJw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+uLXZVL0LlbE5n/v02m9iLzsEAMRRWaGcnKS6rtBqDzMcCafg8
 pkDZYUkgKsgV5rWFvOcYCuSycW8Iil89mTzCgzkO52iB+5qCSQkj9GEx5t0ig6tgZDX8AxLZka2
 GH6H4OVA/Hwnpr4cihnEttW2SjZ0ROcAeaJBPeWX6BN9l7QePkVE1nGVdps4vemiODbZd7RoBmq
 LHNVd+KQEIMdGjCdZCPuKqZ+Gw+dGjyn+tDYUlbOCkYhjyZQ==
X-Gm-Gg: AZFdTZfRB+x+tGqHcPZ3r0+xPIqSlKlnnp3qi3qcdwdQAlIx22zQbIoJ0j9iIt9d3vN
 QzzfVUg9GYWFi2A+mm//NBOhRGlyLdlmsNnPvWS3v12KqYkw5t5/aUHmISyTuaPahd1y1608uyc
 4r4kFphPqZW6OrjXJo7BewYW4v2+hX0XsgcMzTj3wKj60XEhCwbTg4SxoLig==
X-Received: by 2002:a17:90b:2f8f:b0:3b0:9bfa:72b1 with SMTP id
 98e67ed59e1d1-3b41c942d13mr20572889a91.49.1795694667856; 
 Thu, 26 Nov 2026 04:04:27 -0800 (PST)
X-Received: by 2002:a17:90b:2f8f:b0:3b0:9bfa:72b1 with SMTP id
 98e67ed59e1d1-3b41c942d13mr20572850a91.49.1795694667362; Thu, 26 Nov 2026
 04:04:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
 <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-6-3fb94f5534ca@aliel.fr>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 13:04:16 +0100
X-Gm-Features: Aa3M54pnB9NhEO6Ylxt6lEzs1c2Wp_th_l5IvL7KXYy5McWsZMXy_VANhdE7X6Q
Message-ID: <CAPx+jO_K+sEwm4CCBUdYz0FzJuYNhKizy4VDpQ=Ystm1aPxbZg@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] pmdomain: amlogic: meson-ee-pwrc: power up
 memories for boot-enabled domains
To: linux-kernel-dev@aliel.fr
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ulf Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: lChErocQYV5CqQxYGcAdTnvQ4uT7Weje
X-Proofpoint-GUID: lChErocQYV5CqQxYGcAdTnvQ4uT7Weje
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NiBTYWx0ZWRfX4oZU7UI1DRjJ
 ANFpLiZTUa3/8Vm+C0guUI2wevrU6GgV7mwLMnSdPWWZytoiGKRa3qd/wtflD4k2MQxvaUsPKqe
 6FdMOi5iTJGE3DWrfUpiUOxJ8CMB4vg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NiBTYWx0ZWRfX9LOB8LCKQAo9
 HmIiXwDOfhnaqqt9cGjejBZe2pMzJZeLbZ/PLS3ZrtprqJqXpKQFBvIyJE6TJupubkvfpIoHa7h
 zAiGI2px8KYMOumkSeIoT4yOf4DAV7Lr2OM4aFJMbPPR5vsjL07UIm6RfDibATiPGPso2/Nm9bA
 sdKRIptBeWwR82NeOlAOk0thMSmDUP4vlWhXV2H1+nDzSk8syvj4qb/PNvjbHWYPJB+6mBG98k9
 vtgyIqRxt4p02EAhicOZaV5p2lzuuAWWgAbPguQGqDZ5NujM/oHtAv3TvrVvIM56hEAS6gkQKVZ
 /EzO6WJxXg167LHpzonPFVtjI+ufc+TuD2N84+G8yOsnm6YyenuXdRQr2hsBRS2/Bf5IDz1rD87
 mPFuGQrAsqcFTmN8M2z88huxdFeAfr3grGWhcSWppUtWRpIEMtwVJHoS9i4m6EB5Hqn+HNSkwC5
 +D/Tg/O0Opb7BdxKyxw==
X-Authority-Analysis: v=2.4 cv=Q5VHcI2a c=1 sm=1 tr=0 ts=6b08204c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=zH7TnIvAWWhA1n-d4cAA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260046
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 8:38=E2=80=AFPM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> When a power domain is found already powered on at probe time (typically
> the VPU domain left enabled by the bootloader), the driver registers the
> genpd in the ON state with GENPD_FLAG_ALWAYS_ON and never calls
> meson_ee_pwrc_on(). As a result, the memory power-down bits of the domain
> are not touched.
>
> pwrc_ee_is_powered_off() only checks the top-level sleep bit, so a
> bootloader that enabled the VPU without waking every memory block
> leaves those memories powered down, and nothing in the genpd framework
> will wake them since pm_runtime_resume_and_get() is a no-op for an
> always-on domain.
>
> This is a preparatory change: a following patch drops the explicit
> HHI_MEM_PD_REG0 write from the meson_dw_hdmi driver, which relies on the
> power domain to power the HDMITX memory.

A question, is the target to drop the GENPD_FLAG_ALWAYS_ON bit for
these PM domains, once the consumer drivers have received proper
support for runtime PM?

In any case, this looks good to me! Do you want me to apply this via
my pmdomain tree?

Kind regards
Uffe

>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  drivers/pmdomain/amlogic/meson-ee-pwrc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/=
amlogic/meson-ee-pwrc.c
> index 338f70d77bf0..b3ae5cd7bea8 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -392,11 +392,21 @@ static int meson_ee_pwrc_off(struct generic_pm_doma=
in *domain)
>         return 0;
>  }
>
> +static void meson_ee_pwrc_mem_power_up(struct meson_ee_pwrc_domain *dom)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < dom->desc.mem_pd_count; i++)
> +               regmap_update_bits(dom->pwrc->regmap_hhi,
> +                                  dom->desc.mem_pd[i].reg,
> +                                  dom->desc.mem_pd[i].mask, 0);
> +}
> +
>  static int meson_ee_pwrc_on(struct generic_pm_domain *domain)
>  {
>         struct meson_ee_pwrc_domain *pwrc_domain =3D
>                 container_of(domain, struct meson_ee_pwrc_domain, base);
> -       int i, ret;
> +       int ret;
>
>         if (pwrc_domain->desc.top_pd)
>                 regmap_update_bits(pwrc_domain->pwrc->regmap_ao,
> @@ -404,10 +414,7 @@ static int meson_ee_pwrc_on(struct generic_pm_domain=
 *domain)
>                                    pwrc_domain->desc.top_pd->sleep_mask, =
0);
>         udelay(20);
>
> -       for (i =3D 0 ; i < pwrc_domain->desc.mem_pd_count ; ++i)
> -               regmap_update_bits(pwrc_domain->pwrc->regmap_hhi,
> -                                  pwrc_domain->desc.mem_pd[i].reg,
> -                                  pwrc_domain->desc.mem_pd[i].mask, 0);
> +       meson_ee_pwrc_mem_power_up(pwrc_domain);
>
>         udelay(20);
>
> @@ -478,6 +485,8 @@ static int meson_ee_pwrc_init_domain(struct platform_=
device *pdev,
>           * prepare/enable counters won't be in sync.
>           */
>         if (dom->num_clks && dom->desc.is_powered_off && !dom->desc.is_po=
wered_off(dom)) {
> +               meson_ee_pwrc_mem_power_up(dom);
> +
>                 ret =3D clk_bulk_prepare_enable(dom->num_clks, dom->clks)=
;
>                 if (ret)
>                         return ret;
>
> --
> 2.56.1
>
>
