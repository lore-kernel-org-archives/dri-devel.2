Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EE606CFB9
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQcUM9L/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fmKOfCCO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 686D510EED1;
	Tue, 10 Nov 2026 09:35:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E606710E4D4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:34:58 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA7kgJc2779714
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OBBzM+x58lSGjC6iKeoiB5yP
 FJBsxPrwM8tp/hy1BwA=; b=jQcUM9L/ieCNI5pHGV3sB6qxYLZR92hzLhXJOhDI
 4KlJg8X5ahYE6N2AlaztoAwLuI+p+H2c5VI9uAqqFiqNz1LMUa4vUiAAExkzRvSf
 Wfk2v6kc/rJ81Vdml4z6cU1Zp8af1Glw/deQuVcYvt3x1kpQN2ftPUWQPk0zDBx5
 IVRY1GVmSLnjWSotqjufr43LYK8BfTdqVghM+3zqQgYx+1OSB2zbqi9GJ9XjtBGZ
 6kRMzMovddf5Bv+pvSZmnwIDBIAWCm/+h+hZwX9poPSdszW0P6wYAFIGyDpcFouG
 bYicA9kS8BmTp7MNeXT9GmqPJOdVQW4BM5MK8qy1eIIg1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8e37-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:34:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f20addba1so331547685a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 01:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794303297; x=1794908097;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OBBzM+x58lSGjC6iKeoiB5yPFJBsxPrwM8tp/hy1BwA=;
 b=fmKOfCCOtec8gvYHOPsf1DmSYAon5vyKUK1naM7fyiu/CKCjA0BBnl/nSkU/6nRJbU
 VuAmPmOQBW7bBK4ne1VYJbsgwVkREsQVpZ8A5CDJAXGlvH2OCUY416IYMyrDB/KjZ/p8
 I0sdq+XfgQz5vNmGbr4ue5Shh4eGOcGlgWIZ+NmjnY0/mh7CiOr/3IJbz6S6EDmwOBQN
 FQCFUY/EtLYKKu1rkSBZaPYgfGs31xmLqFp5UHLdgKCAgq9IhwD24v8lsLrhK/bQ9Cns
 J/bFqwtrl9hUyNSXA1EPiwfl1Uubqd4Dd1V5xwUF4osJw1AXR7r4hQigsFb7X5AwQK7g
 YNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794303297; x=1794908097;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OBBzM+x58lSGjC6iKeoiB5yPFJBsxPrwM8tp/hy1BwA=;
 b=sWY8cdkZOTVwcvY2RC43Z+OXCYF1iwNznDMKHmyVYFbYzGhlQpA069UE2Kh1AMkbLt
 54D+5C12gRB8/Gw8Bmup17+NklnLpQOtB1opAggvd7r6nSWqh5D1gUJO8Fi6iwu9vi/3
 DBCZyZ7Taos1cqsuXucAbQU7c9U9zcYKGg6PX3/FbnM0Fn6wewkVwDlu6OMraZnN+LCa
 2A7eu1LN9KANubgJci9zKq7kwDFZSLLMK8gy0BMLv7riI43j4gygIPMGKJpq2p8csuIK
 R7FBpfFXiZ2XZhWFWBmuZ5X+lXZellsNl8hqBRE0RBAreexB/BSZf9ulpN1SusMVa2zB
 xIvA==
X-Forwarded-Encrypted: i=1;
 AL+hErGG44eDK1HFGiIBgi5qplVhc9Zn6QesDj63jk2JAtJLlSXIla/u03FRunpPWn84ak0zM9CC0a+sX7s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Kg98vXwRyfzX0zeZblhjhzkXehs7WUUwT4tuUKs+/gQ+rn/jI
 YRmTCbmuREI6cHlh7mDyr7lF9Kq8qZxEg16ElrVOBm3jx/zNEqFrnrcZ6R8NDMO63QewBLA3PlQ
 +ntjutLn0lEkZbHD4YkwP8/J0YCOI5fmAY7h/509ytxot8ncmZqPuukcJNqBTyNn5Ue07Qtk=
X-Gm-Gg: AYBFou36SDHEXkoe1toynHbe5LQ0dS7uFyj7U+Cze2Z43l640PL7wEfQUukF0wXm1gD
 gZAvt3GcQq1Jrstg0FEOFsPRlqn+/M4+okEwlLRl7Tx5M1zgyJNc8GClCfx8znYDyQtlti2tko2
 z8QTxZCuN/sMuYRZq3NWi/tMwTg5wZlgQiBNVoFT48xxEoqswG77+xmZrxUN6V3vUnik6RhDdbm
 XAHQBcESzFByWIUXeR/3N3K8wROem3SDms+eASH40OS0EFV8xO6Pl+KuT5fN+jAseAyp80mlRSk
 sj/oej+fTFR8ryV3CBr2ou/qXIDbNtCuKfyZMieqTtIkTKqGo1fFJ7ifHf8uUuv+z4ctSb2VptS
 u9HgvIQOUFdm/qJcSUATehqBZ9+QKII9AXPF9ExrEN2fcVd3DeDkAUSt/2cCmuRhv
X-Received: by 2002:a05:620a:31a0:b0:93e:95ce:539c with SMTP id
 af79cd13be357-9479f1d7b57mr308876485a.2.1794303297217; 
 Tue, 10 Nov 2026 01:34:57 -0800 (PST)
X-Received: by 2002:a05:620a:31a0:b0:93e:95ce:539c with SMTP id
 af79cd13be357-9479f1d7b57mr308873685a.2.1794303296619; 
 Tue, 10 Nov 2026 01:34:56 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020433casm49545735e9.7.2026.11.10.01.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:34:55 -0800 (PST)
Date: Tue, 10 Nov 2026 11:34:54 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 29/29] soc: qcom: pmic-glink-altmode: skip retimer
 reset on DP IRQ
Message-ID: <c5xtcdsxds2476itvx7m6s7u2efqnses3lo6ugqxnblrxwu447@g5r3tmvqzdzl>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-29-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-29-d040fb33db5f@oss.qualcomm.com>
X-Proofpoint-GUID: VtGiw_2HVeUv5ENq8AzpbP2EQnC1MNYl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfX8wlaxfAaK5B6
 2LsPj+SCokI4wloOEqpjervBrhwnX2GF3AcQC5v6TPr/IBavxVZ98aVQ89j62kwp4y5BMxPIxu+
 66XtNs7x4bLKfvGQL3C5wFHl4SHWNZI=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2e542 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=a7TajEPTInBWvrS5HM0A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: VtGiw_2HVeUv5ENq8AzpbP2EQnC1MNYl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOCBTYWx0ZWRfXxbvGW1d0+3pm
 pZapJvzKYrQMpOpKb+xIng8Z+k9EJr7XNY53oE/+0JYfUFcAxXxL3YiF7QM5MqUXz+fpDezmV2C
 zGGPXbiL2TvCp7Vg9kb26Qou8g1nsmQCrnqYVdG3ZCofoMq9c+YCEZS3sF4DgXGYMaK2tefXO8Y
 NfxSRF1Lc+jTral5b1BcsYQp2pYZnHik8g9ip4VA7UpNAyPUavyiJfvtx8azEIdLhp6iuSw8v1D
 cQlQWouKMvh0kEzAl7dfdr/NrQt8gAIEW6vO0gGe921/IUU28OXwBDYt8w0ArIrgPTcGX5JHrRf
 8XChwA5dhBG2XoOAj0BOAI4AOn0wnkhfMRfWhXVIJncwS9lRSMfoJFD+5tG/Bhy1mLGymlolN+E
 ELZ4dswe9o/ICWhFZijn3f7iZMRNPHdkts7uvxMWBthWrTYNYlasXlEG/lMURnDNbd+69EkxnPf
 tZH+5N8kUy2t4wmdwRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100038
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-10 12:54:50, Yongxing Mou wrote:
> A DP HPD IRQ reports a sink-side event and does not imply a Type-C
> routing change. Reprogramming the retimer for every IRQ can reset or
> disturb its datapath while link training or video transmission is in
> progress, causing intermittent DisplayPort link failures.
> 
> Cache the successfully programmed DP retimer mode, HPD level, and
> orientation. When an IRQ arrives with the same state, leave the retimer
> untouched while continuing to notify DRM so MST sink IRQ handling is
> preserved. Invalidate the cache on non-DP modes and after a failed retimer
> update so later DP transitions are always configured.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
