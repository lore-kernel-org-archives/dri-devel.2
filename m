Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A5606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gorF3E5T;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TZrve7mB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA96310E031;
	Sat, 31 Oct 2026 20:31:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C87C10E031
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:31:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJF42Z2614421
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ukK0x8ix9SWhHXUtQP3CPTLr
 QTiWMUDAJDT6GYiDeY8=; b=gorF3E5TzHG2eMX/5+4poZUAltnSP03K1fpI+ih6
 MHOyyjg5o3wWfkn3ydZBy6A/NIfc41lQDqWzwUjkWbpuBwE1+2JlxOPMIFyABWHf
 yFYDWaknyjT6YRAuypB+B3oVZrFs7iz5P3+L4Pn6u8JHilFAhqFPCzZ7sm5a+vxG
 JcFp7WiTTrtWTNd6Sh7NFhsQK4I5KA0YUSXEWbLoIf1F+AAP8trRXxDzffw1eWQb
 93XB39wD0J0JAMNlt200rbKNzNfPldCB3LvHjGnLl3fLenk7v60fso0TRq3Pscsn
 iu5pWL7gNXgtIYCmwczHS52MxHr0c+TWfR0yxanlZvqpbg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nft41x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:31:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f26dd2165so505479885a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793478692; x=1794083492;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ukK0x8ix9SWhHXUtQP3CPTLrQTiWMUDAJDT6GYiDeY8=;
 b=TZrve7mBe0aCJd924u5Q6HKAhLN1ln2g/dnyuRbe7yaHOo0m5a3QLhiVQLtfTdWQxU
 VGE3m+sKizOCIs3VYLrn8dnX07SKjKAB14ufHGTgS4S72v4sZ8VU/tYoj+RUHfYU/UtZ
 CSaYSDfNZpKGL+fzR0ERCaYT5jFI10LH/1h0im6zqgJS8yzWN7V6D8QhFzjkSE3QLjrf
 1ulE91tb00buwUpmMXjyImX9SHxdukm1ljYQSsRZjBHjznnfhqgNQ2XGcf/QZH7KmNC0
 02FcMmxiN8PQcMDt8S0u6a5YHr5ad/gg7RpNLnV+Lrp52LpxK9vbnGxy5vmZBbigQeG4
 18rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793478692; x=1794083492;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ukK0x8ix9SWhHXUtQP3CPTLrQTiWMUDAJDT6GYiDeY8=;
 b=chue6y7yxXmb3FI0SPBMipySgtL89ABNg23zrZcFOb+ZTpDGg6VJM9e99+1kZmuIj+
 tJgutY9s7Bdil3MjFqc9KCkBkuOsduEp7DKlVjt4qmlgnSG/rQz4xuMdtGndr9JRzt3k
 GO+r8FBjm8agtz0pquM0ucaMtzQDge64I/Qb3ZVm/NB9uBHlVXwi9xeEj7tLOLZ/BKdp
 1KzvdGGhMh3oS7DXpri2yddKSzR7hkOdQj10wnpDa89tem2R605xMqda13Rlei/RxQNo
 icZ3Hj8ZqNXUDlZMvQHoaT/gyAYmmkWVPkmXKYht+x5TkY2sEjabca6e7MOY4M+y5m+z
 nNsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6xyQc8dg1r2oXxenY31+1c+3EVVsdB7ZK8AyohZ5ksooPw+s1Uo+6l9sK+24yuGonlXCsH3cxk7o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLU6ZkCJHIagDFPlab7bYOMITYdfC6Mno71tZ2WLrbB9zAfYJIs
 ZxumJWWm4ZlxFzHx01PGGmREJo11Cjqx7sdvTRVpQuFEVtXdfaHVX7wgjIQLSqaKL1Dc/m+uYUr
 kR7MqkiNfZm/uIvBiUZ8Em4wWTWE36oYOQ/+ReK8Jb0s7dRB0OW28QksNzjVE//Hk+LLFWIdtrE
 zbr8Q=
X-Gm-Gg: AYBFou1mhh7GiV0XK/mjbaEk+OoUiMmSnruskT4TVq+MgJwBen1/m72BuTPh4FK+dO3
 WRvOROvawBR6rf2XfBJZoSnBgdy/bYOpsEUzKywIaH7jQL63QKBvTtaJE4fOjMsoN/XEPeRNUFm
 eGGFY9WII306n4Qyv6o30XQHlIdpwXjN8V4ApZpalHg4nnD4n+EJnhXq5Xac0o+hqh9ZWUKUsCw
 +li5DHzt8VUtwG5bS98Tph1AO1m0oRGFV1JkCbVUoswtNVnDzIkn/Nn5nSH57Q94kVt2gxXqzGS
 aaIL21ouQ/hu8dGgwk/1M1MY1gXgjqu8se8Sfwqnuiqe54df+oLU53StoCwPpKaMOkvKnAil8+F
 zhrdaKtEicWMTqq4w58Z0UaeqFnGSriJq909kRi/YS3MYAgbxTTZPPCLmdYZV1mmb6F4NBSmPmL
 C9O1SjuKbeoTxtXIfl6uL1O/zGnr1FW/RG2OLuWaknVMihlkw1BWCkB2sBk5Gnbg==
X-Received: by 2002:a05:620a:a8cb:10b0:93f:2ab9:7294 with SMTP id
 af79cd13be357-94430bc5284mr315062385a.29.1793478691917; 
 Sat, 31 Oct 2026 13:31:31 -0700 (PDT)
X-Received: by 2002:a05:620a:a8cb:10b0:93f:2ab9:7294 with SMTP id
 af79cd13be357-94430bc5284mr315061185a.29.1793478691386; 
 Sat, 31 Oct 2026 13:31:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0738dc4sm734554e87.51.2026.10.31.13.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:31:29 -0700 (PDT)
Date: Sat, 31 Oct 2026 22:31:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/msm/dsi: take bonded DSI master cfg from per-SoC
 config
Message-ID: <hdft7yrut44wirysbfigpzgg33lucyb2ruyntcxu447kcsrsqa@k73fvjrhqcch>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261031150305.1107572-5-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031150305.1107572-5-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX3ed6IUqfmff3
 xKz51JwCFE+Pbkb215Nv+orXRoOsJTcppWAnrjvCaU6oVbfyKVKOL9KQwhyv6xXAiLGhz06m5KD
 /qeD/cylZ88JHmJLCigJ1ayw5Ou8vQg=
X-Proofpoint-GUID: f3X8Ms518CrTf5zvvlE2hQ9yzVpOY-iA
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae65024 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=LlY1mk_YLf5cAL8JajkA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: f3X8Ms518CrTf5zvvlE2hQ9yzVpOY-iA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX2e+lzdgThrlY
 0Ox/tcDxHafK1HIY5yIsIuKHQ/b06/fhUsrmfZrDL+KJBHW2bD5kypBNnXsnQB01Dw69T07rWfE
 PiJwlmez55NqZjMk1wxeWIMqxS9I2AwQAjOs0nh0aOlm5v4YJnkPW6lpWwJH3JSc7+ke9BS4qYi
 65gDJIfV1azvE8itPeUxSPG0WKwDR7WmYfuNtVKJxc7QTKTkXAXavEX3mKXAiFgFZ6yVyqRdNuP
 AIoUnatPkdPVbEsu6xn1aRNbmOLH1FOLXB1xYL94IwIqKnU3BTNE9YszrJCGjuNtwg9/Fe/+Zl4
 kN25s62Po5P3EC90YWEEvVIsm6M2bMRfY/gSc3MiLvdnHVRn2uF3TfT0NDixkoJxG4ehH7cSu/n
 rSmErWmoiF3oUOKwpgSpFJxa1u40csufdYseZ4rtvCriYRaSaQrAucHM1kFPd/X3cvKu5HHjp9N
 /r8vrNZF7d6H68ZyaTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310081
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

On Sat, Oct 31, 2026 at 11:03:04PM +0800, Qianhui Xu wrote:
> Take the bonded master link id from the per-SoC config instead of
> deriving it from probe order: the master is a property of the SoC's
> DSI generation, not of which host happens to probe first. Behaviour

IDs are not assigned by the probe order. Master is also assigned via the
DT.

> is unchanged: on sm8750 the cfg entry resolves to the same master the
> hardcoded value named.
> 
> Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h         |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 11 ++++++
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 49 ++++++++++++++++++++-------
>  3 files changed, 48 insertions(+), 13 deletions(-)
> 

-- 
With best wishes
Dmitry
