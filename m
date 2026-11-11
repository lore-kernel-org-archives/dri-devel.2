Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E8606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k3Bdbnfa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WIsxZBZ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7516D10FB7C;
	Wed, 11 Nov 2026 14:06:24 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C24E910FB7C
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCYvYb1359103
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=KXBhJCFqA5bIGvWFtXt6+Gu8
 6y2tdB1JbBanpyQaxXM=; b=k3BdbnfapFZUICnXw4zScnfcFSOPWBP3oRH1V+Dw
 eg2ahj90B9K7ySGaeK60xw8hqm92X3/AQ6W6/mwTuKiPLsgVVikoyWrlpr6xGWmQ
 L8+jlPtBHQFOWm9vFs/gQIltMeYtd01HYEPFCE8/qCFTVHB4sX790VzH2qer2XNS
 5f9YiSA4EKbVrxIw5WSGRWYqQDkZ4yyhTUlcgoC9CipCuXTf9XjqXRydX4TyQtYB
 ixkSGXijVhYT5Uf1I55xSIFZCfvWFWeyxjYQRIKUPYLqm6AV2xNlHW1Qhmfq8tGx
 WlLaGsi5227/L89FAhmHv5FGD5et1b60gIIFhLOs9KvIxw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7psj3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ece7f075c4so951486e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794405971; x=1795010771;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KXBhJCFqA5bIGvWFtXt6+Gu86y2tdB1JbBanpyQaxXM=;
 b=WIsxZBZ005Sz1gl14+oGjJJ1gO3a15crio4s78DCkNbJTqUXrr3CkY0lotFR/HmstS
 cK7UEaeidydjilT7FlqloMuhZFGuAMUfEzX6u4CRM0nxPRQwWY7v77pGg7UnwB+WalEy
 /ALYSLNhzT+DeI5IEeoNWHpCmQWc70F6ci5PJ/YaCEBQgDQrpTBeJGDlBDWfAMytd6PW
 scUK6XzCFGVVdeEtnV5K+EeJ2mMsu0YsEtV2YjVt56JCge0MWBZWKSlzRkfNliKK/C7H
 /kbRJcOHHNMdzz2M87wWsyUJs/ZnPlsyxhWiEJHZM4GgYIgZY+irBtKf7dL5Yt/+rYSC
 KiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794405971; x=1795010771;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KXBhJCFqA5bIGvWFtXt6+Gu86y2tdB1JbBanpyQaxXM=;
 b=RuaQk6KudhDNyAAsDOt2zCu9sUxnfEEka3ByFbbjriFj8c1Ymvz5+g2Wtrwv6Jn8eN
 Y4ZeifApocW2/Ui1hPamHfww8eeCiPBuLUrIRxXuhsG8KPDyNEqLmpyQ28rNEvUS2U7P
 OdBrH/9R7+0xJ8YDEsAganzRdO9SYrEiwwC2RGuBBH6M1X5TG+4V990fQAJVEiwMnj4o
 hH0gZmIQNdW0FxZhuvr0Mp1GCNE4GT35gN94qN2x2mfPbKAcvQMZeIvZteS50bi6l6x+
 xS/jTKkBiGEqjOI/mvF5lQ19P0fQJe14ONPN1hBe4woD3qLvjWLxYjvNTZUo10UsiD2Q
 ujWw==
X-Forwarded-Encrypted: i=1;
 AL+hErFptJ4eSFLLc+y7n3lKBxYy7VC7bj37OHj+97l2aqhz9TksLg0lK6Tpvztzln1EFCfBQ2eNLH+g1KI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8OEhp4RNqMNtEF0IdR5e0GYSYgVqA/Y3XSVq76KqwoZgFKmb+t
 JkTCgnX3yv8igs+Zwiww1B3UkDlrAXTGha1hCyo9JPqmgPMIL8d6Gsab+BSD3rLzj94IAcQ94VT
 9QRQLoYSrN2fmpHvPGEtQyorMvLqIjXXFe0tmBZC7pio5LBsNKU52KuYTZsarxrywFJhB3GU=
X-Gm-Gg: AYBFou1JdbTH2s2rtFZ/quVEi3Eyu2a08AihZpNi07pgAPZrydLcVPIzttMPdXaGpaV
 vp5nuLvR+aIkKYG8E0y7dcQfv0gd69oDV+efbiUwmYBZh4JGBemODbfbB4HgsZx5XJv2f6DYdmg
 0CGA6EQWDE1AB3q+psmsMzxTXQwiw+ZNKYNGeFz1UITFvwuAQW6DbPuwpMC7P7hqq7z3tm4/LIh
 HLgOxCdmulet5SZ3XAuokJb8p6mC/kbHOpssQye0nwQn8iDZKtv00HgN9Bejj3d79CgPxEM0ZeM
 q/LSEWk6oPYSFpBDm2FlCIUI/69qtvvxMUVvoSrv/e9x/JXdntnWEJzNeH9l5+w31v/q5VCoA39
 pOned6uXs0kjluc5LH+yXuQVJEy0korxzg4tOBcVuPNVsZDAYq79fJ5y5NINmZ5fuI6ceS0lpZQ
 ZjqP6EoZxigXkKFJVNzJKHhrkTVw0pqFJIha5YiaxBe1ahdXW3YG0DGjl9joKPRA==
X-Received: by 2002:a05:6122:8f89:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5ee1c443198mr713189e0c.14.1794405970706; 
 Wed, 11 Nov 2026 06:06:10 -0800 (PST)
X-Received: by 2002:a05:6122:8f89:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5ee1c443198mr713132e0c.14.1794405970186; 
 Wed, 11 Nov 2026 06:06:10 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15776f2bbsm966580e87.0.2026.11.11.06.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:06:09 -0800 (PST)
Date: Wed, 11 Nov 2026 16:06:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: naidu nama <naidu.nama@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com
Subject: Re: [PATCH v2 1/3] phy: qcom: qmp-combo: delay Type-C mux switch
 while DP PHY is initializing
Message-ID: <xby27hg6ajesijmdclu7f2sa2swv4ednmokka2pbn7uaufm3za@czdij7j2qcml>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-2-naidu.nama@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111104434.2222182-2-naidu.nama@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfXwS2HsAK8Z70m
 9a08o9V2Aucxd8YTUQ+b7IE4vU+pfiN0kGpnrnWAEQSBkeKPFameynoN2Ntsb/K3BQWNs28Qee9
 eAKKN/iS/JpjvajPcM0elJ4SG6jt1JE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX/mX6YxaC9/a3
 PtiDomuEXpYWWWiv9vvTXleHi+bHICBUNqbSClpRyzoEwB75OZkHdQ9Ch7Ns2EnMHmocFcOD6S2
 2MnkhPS39yvAgJlJNAUNDRiH7TVIuChl6ArmawgKIQEthTLKwuYZ8rh+8h8sW3ubltPH6nIHSoZ
 FR23Kvj30Usl4Y5Ia6vUZ3YcqQo+AgU3O8rwpAiG1zXFtQi7U2JDD/zjez7cqMhP98AxE8Hn2lx
 oLOYnZDXy6/v9+5AZQHkHIGe1Fi4foN5g5DCoX/IRAMFqZjBaSNhk4GRhislUm9htpu3efDtUDu
 DejF+QvuJh0I0Qafiy4sGt1e08IRA3dbEh6dRc69TARfLUM1243Zb5wMt4xsBiS7oY84pvqef7L
 LMo0HKSLEf1cJJVEX98JKXMX825lskJjhSDIJtKFdhADqQsmUVeAtOjTXmDnf9UuGBIoWjEv9SD
 2amNgT4SAoua4nRGmTA==
X-Proofpoint-GUID: BAkt6LsCWQSuQc8hXqb50-d5llhyw9R_
X-Proofpoint-ORIG-GUID: BAkt6LsCWQSuQc8hXqb50-d5llhyw9R_
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af47653 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hTi17YcZWSOoB4cLaREA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
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

On Wed, Nov 11, 2026 at 04:13:53PM +0530, naidu nama wrote:
> From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> 
> The Type-C mux switch guard only checked dp_powered_on, which is set in
> qmp_combo_dp_power_on(). However there is a race window between
> qmp_combo_dp_init() and qmp_combo_dp_power_on() during which dp_init_count
> is non-zero but dp_powered_on is still false. A Type-C orientation change
> arriving in this window would proceed with the mux switch while the DP PHY
> is mid-initialization, corrupting the PHY state.

How is going to be handled then?

> 
> Extend the guard to also block the mux switch when dp_init_count is
> non-zero, covering the full period from dp_init through dp_power_on.
> 
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

Naidu, you are resending the other people patches, but the SoB is
missing.

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 61d8b7a5ce8f..3f93043f94e5 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -5163,7 +5163,8 @@ static int qmp_combo_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_s
>  		return 0;
>  	}
>  
> -	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY && qmp->dp_powered_on) {
> +	if (qmp->qmpphy_mode != QMPPHY_MODE_USB3_ONLY &&
> +	    (qmp->dp_powered_on || qmp->dp_init_count)) {

Can dp_powered_on be dropped then?

>  		dev_dbg(qmp->dev, "typec_mux_set: DP PHY is still in use, delaying switch\n");
>  		return 0;
>  	}
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
