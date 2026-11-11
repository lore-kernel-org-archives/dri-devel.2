Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320F606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oAzXh4gm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eBdxPosX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C8E10E219;
	Wed, 11 Nov 2026 14:18:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2BB10E508
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:18:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEHd0H2501543
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=K8i3rI9wo+/NtzfyXb9aiMzz
 mODydmkC1k9o/9EVJ44=; b=oAzXh4gmanBkJL+B/vYcRc7TFflYOnikuLodFMi8
 v0ERCy8aDsQ/7VcVFe6M3bj6Rltxwiyl1tsbjc15YtRQVag4k4zD4DvPQGu4hzAy
 rZHi9oUViLj3NKZ6OKI68d4IKIHs8PXfztLm7Xqxr1+lSzuvlhyJKuEvANKErEtU
 t3gKVLnjchmuVbM45yL3FvSa9ujDPu5RFLRb+tX/HpJFdbs+gl6qPz9DIV6u5DVn
 dlHbIwcvawDMXtSNIghZjf4GbZsfLFs8C3nE0KlBNSeqWhwiVy2ntc84DOdMH2Rc
 10ATGrDomBF11qFXVYJqbRxXga6hD4+wUNkUq+HDcNoSiQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm9h3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:18:35 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ee0977403bso2511721e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406714; x=1795011514;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K8i3rI9wo+/NtzfyXb9aiMzzmODydmkC1k9o/9EVJ44=;
 b=eBdxPosXdzHshgCOnMoPcw90Sfycz20Ewo9XPuvkYbkG4RIqX4lwCTjg035vaj9oiN
 y8TwpYNH0DR0DIqd+SWhgA7SRN4Y1LPmlkZqZ2t2xxszfqs89WyR1U4Q5Eg1ce2T7vBE
 1yd5JJieBiiYQkh0Wq/Hz7GHxFmYhXrLn1IxpRbhC/jmSCP8fWdwTKo26hoFtO5kFpbM
 jdHoanCB15ERymXmUz187DN6xAD6ituN/YoswGAqsfcDVpoYH7NO4BmyvRPFTOZuLCUi
 0895Q2MMoDwJt5qCbSEOdawwgUpo+Ls2zCzn77NbXdnTzYwLBBkWLuUQc312OK83Jkn3
 GhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406714; x=1795011514;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K8i3rI9wo+/NtzfyXb9aiMzzmODydmkC1k9o/9EVJ44=;
 b=yqjcwoqr5KM5h9v0zru91DxTHbrazQLnleKT6ObPF2o7dBWNaXnFdoZzuPAAgbYV3A
 EUCz0l6SHLSAfJvZ8OnSqpAEiXPFaiUo5yJXuEPene0ero/rOKunY/LYKA2z0H2kLvmA
 78jHndM81BYXa/+YHbOQon2HUDHJM+/XxWI1FLF4SaDiMTS+OGflVVEjMlyAwnglK20A
 DTQ+19YgVCoVIbSToqT6TSDzWWgvCmzmBQ8dbUtlB44mHspwC/sWfHX/3o70V7+yt3Bl
 LpCkbbFWa7sizt0L4k8BKGesBNbdUlDTteMWD3IZXc3FwZjS+O+E3COpjZjwO6wt6Udc
 Na9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGyf13A/7MBXb/QZogMqI66jwNQbmSrNUoGRpuaaLZOInNHK8I1ITQWCCEtj/is58lGYcpOWi34Vgg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8JijjpRUvElBzOdt2Po4+nUC5cuPWcfsYaz6WhDqxgHaA35Mc8
 Otpv71fYqwcABKWU1+tRiZI/V28BBeJY2u3IrqdS5o66yXghxZjdsD3kIR2OV+JlW3JZNu+5Bzc
 B+bxgtf3SY1+lfF5OqMd9yKBNNHKPr6lagT0/zrMJx+H/Vid7ZPS8/HV58cK6pvbMDc13I/I=
X-Gm-Gg: AYBFou0eHUDymffKMoRUYQSbelBfgGB7bnS8eclI2Tlp5x5OPtTSuDZtKlyr/b6SBZW
 pNRSWG17pIBMvehdZoiJ3V+DwP+KHVMoQhQ3Nd3f904UrYRnHsijic1xx9yAfMh1IN5shlgC69M
 JIUW5Em/zIXdTpdo6LD2DBMJrv9FxDwfuAiMEzLgXd8dLRy2qUN3RQGcqjejPTXyl+CrbaG+ELA
 LmhstKGR/GacHF90rf7MrdXbOlYNt+Cc6FlUF59VHXoDMUIJjAwQ/D7rpXSu9wkuXL7nr/ysmFc
 jdO4uQ5xJRwPX1cPecU6rFyGiYP711c1uu6bg7MP2eEtT4fbd5btgiP+RM3jY/x1Klx3gv4eRLD
 DEREUaixX9iDE57bpKlO1lsjTCfGIH3lmKANHeHampOpkJVQEVDLmX37YT+rFhlWf8rSFLcTYPR
 hYMk87kswhlJKYN1aE67WZONH2lNBRyqbtinqLa5cbdTduPZfK198Qd/0Fc45qNQ==
X-Received: by 2002:a05:6122:1825:b0:5d0:1207:b693 with SMTP id
 71dfb90a1353d-5ee1c2c2c00mr973619e0c.1.1794406714480; 
 Wed, 11 Nov 2026 06:18:34 -0800 (PST)
X-Received: by 2002:a05:6122:1825:b0:5d0:1207:b693 with SMTP id
 71dfb90a1353d-5ee1c2c2c00mr973609e0c.1.1794406713974; 
 Wed, 11 Nov 2026 06:18:33 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae09172986sm11882611fa.2.2026.11.11.06.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:18:32 -0800 (PST)
Date: Wed, 11 Nov 2026 16:18:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8750: describe all MDSS block
 resets
Message-ID: <fglkl4ksxin2citf44fvrjrqupz2a7asbuwxmkja6dbgu5stcx@uyjfipsp2njl>
References: <20261102055026.438521-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261102055026.438521-4-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102055026.438521-4-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-GUID: p3XVk1wRekiJICz9lnaBINoc-9_la6dU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX3zBiW9T9OX0M
 Yr1v8axuNlk3W196xzsFXXFZjJZhgbt8aTlEda8Sxbp3+d+4xv9YjosyCeAz1MUZfaSP8Tg/2bP
 4AcJDVKTqFcBtOzV7TXzLPvFVGEEqP+tVh6wS0Axut+pndL7xI0KRBBTyyCW149FnzkE31Shz+2
 ZO77QOGdS8A7z/R9z24OLxIuN6ewHRlxqsSXKPtjnZMWD57RC0O7nxMZiK8P7GNpHO4/56e2P+y
 ThugXkCRrbkm8MXwTqukIR4YyhG8S2Y0RoT2u5Mf4JgsYYtW7jEQnZ4H5mKS54B/MCWHhLmwfWD
 H6H93z8lUVu35l58l7eHdK4OBicuIOLrZ7Ts7OvTIL4QgG3veX1U3QrQMvGoZ9+uspls64efe2+
 fk4q3NxxXjOQDB7dur6yWoOKo0dsy66D3JmCri9Ieuthc48GvOb9hd00fsvEv0pVPjVY1Oe4u/U
 yBQEHknv22dfndU0/hQ==
X-Proofpoint-ORIG-GUID: p3XVk1wRekiJICz9lnaBINoc-9_la6dU
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af4793b cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=NzLwe9Gq4q7PvPqZN-MA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfXzUC8/2kTOfe1
 8oBotDtA5NFKSPCMff27LYga3gt91oF5Msa41PwAU6pcn+/wyKt7DBgOQ4hTF7P9FNAwVi14zvl
 R4vG13FPl93YJ25VxGtqP7PwBzeUnhA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056
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

On Mon, Nov 02, 2026 at 01:50:26PM +0800, Qianhui Xu wrote:
> The SM8750 display clock controller provides, beside the MDSS core
> reset, a block reset for the MDSS core INT2 interrupt controller.  On
> devices whose bootloader hands over with the display block still active,
> the kernel so far reset only the MDSS core and left the INT2 block in
> the state left behind by the bootloader; command-mode panel
> initialisation then fails with command DMA timeouts and the display
> comes up as backlight only, without a DRM device.
> 
> Describe both block resets so that the MDSS reset returns the MDSS
> blocks to a known state before any display hardware is programmed.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
