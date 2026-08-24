Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D14C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFC310E74D;
	Mon, 24 Aug 2026 11:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gklqmwlf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UTqB16WO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA54510E74D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OBMYAv2648057
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uhZFMUq0G82N6cZ0jr/Dp8Ye
 4zJGl9JW5FIR7tFFlKM=; b=Gklqmwlfj9AzCkg/arOvToonrhf0bYY/rB+R88JX
 3w6WMi/u3Bi+iyuC5Z/s1CKgJvg9H3owZXmIpgfVN2qfyWO/yTvkxz9y8/Qja3ym
 liXTh6B+i0GkURoYSqt1egIKbsIjuYTVA4S2GymUThJ8m5yB4V4SuJAyhCNKzcrk
 cKoJk6hOpg/1VjmtI3TJ5U8NRRZ/Lbjalee64MB+/jjtG4LUjwHDfXUTHqZcCyEF
 +6hdoRjcq2ZOLtDL/ZaxPCFkoeon0XzTv36UH2wNqls/gmvgz5j0gGi5ukR/L8Xw
 N0xB4JnHmryBkKdZPwEGkkxIvj2IL7soNYf8wZSDCl+4Ug==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqn97uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:31:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso47699391cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787571075; x=1788175875;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uhZFMUq0G82N6cZ0jr/Dp8Ye4zJGl9JW5FIR7tFFlKM=;
 b=UTqB16WOJzdquMkeGYHhSKtaQqq2s1KxH6eLPdh7Cn9cUmYJ247YfnsOvyRTXswY1h
 0dZXXQZTUYCO4NLIlucJ5nBBF4WRN1/QCvX782G/tV2IHY7Ui7Wf6K0EXL4cqSrM9QQg
 Ckq4MZpPUzOyGY3inC8zkN2IkKmpTadwfmCYCjmtd1IeIdHN8eFvmGwQLq7wvyOjsD2x
 GAPX58hiJlBFy3+pJa5M3LvxZF1wRzG9b1EkApvf4XaGFh9UEWsPvSJj2mqHJ2/Ot/6D
 6Yx30grrd31UT3bbZPI1CHs8BFmbrSs4GRL20MZ4Fdy9IgyeqNcn/dnmKf9wnb0iX45J
 Epxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787571075; x=1788175875;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uhZFMUq0G82N6cZ0jr/Dp8Ye4zJGl9JW5FIR7tFFlKM=;
 b=Q6JaTuv5iRXyRd3nBxWbb6OVEiLcwEXeT4IdahRcwvhNEmqxuredqWUpUoO72AWb50
 7zHBRmzK2E8m7en76zQUJ2CxevK9ATm+06wxID0HC7u5T5mSQJNjVK3w0yKjxvH+iHMU
 swtLosF8VKxfXpD/FLA8t40XVQacR/DZE3Da5EUjEJUQfnFwnptfnBOcfo4+eMYotKt8
 RFu99QhPhE62zTvaL+FEGDqTDXfzakKnf7DDOKA+rmtkSaRfWnNO5m3XXk1dybDFjwEp
 2RrKe40aue0tB37bUu/vnkImsk7pfrcrEjZeNi/9sfrF6Sv4BUb32bfgwSeLg6Aa6P4P
 +uRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJVnNWjVcSIDZW4PBCmrF1OPRdKWrYgKu0sjGaltM0bAVTcQQlp7FoimV2Y/6S7t54G5HY9UtWCpo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nF8w8n/PFt89HzttYnAsSU9q0eylDItQ/rwmUtn20iIwrJP7eo
 vHGNICOD/+M7IcISALSOlXMZNu+sNdO2EjeChrmoGIIMo2cOwILJv8fuCVgANWxpfvnAFTCZHMq
 ABn1ecRDfjryz3sXA6b/gHlnIIVtL7q/Xnl+epwpREffjWp0gTj0AsYQqBQVhd3yj2+yl1yk=
X-Gm-Gg: AR+sD12/pEb1fEC9CRn1CToY+66dMFnoXB7afH+00Hzy6byIonS7VWOVMukceohf0Aj
 d4ttPV+zlUVxTnjIJZucZYjZQec2AdOm9JfRScqwNLXAowLx06pq5gyqQdVblTQ6uahv48r4QUl
 dS7QXMiXAPZBiE8nO+RsbgvMSiM3bYrWPrm7jq4vBLnkUv381kVKI/Zm8I6maGlkSg6r1oo4Axy
 bEcUfjaat57lV/G57tsFZ0XA2C7F5EIZIZ4imLD6TVvmWHyBALhufV5x91a8YMZYzBhOy7qJlBH
 vw/kPc1obVsUSFqnjauuJkxD8563awbIHM6NZMpPa4exmcdHcdGGKnnrAnKL9jrjyGR+CAIh0kH
 HtP1svW/1lTa8bgI=
X-Received: by 2002:a05:622a:4cc3:b0:51c:ae7:fa1d with SMTP id
 d75a77b69052e-52df56e10f9mr245521021cf.5.1787571075039; 
 Mon, 24 Aug 2026 04:31:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc3:b0:51c:ae7:fa1d with SMTP id
 d75a77b69052e-52df56e10f9mr245519981cf.5.1787571074499; 
 Mon, 24 Aug 2026 04:31:14 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e7esm1342927066b.46.2026.08.24.04.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:31:13 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:31:10 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com,
 royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/13] pmdomain/rockchip: add optional per-domain
 power-on settle delay
Message-ID: <dn5vlrxg2vr64d56mqibriz5y7ebeqezkv6f2aqf5qd2gti6y2@ohdxvj5dnscc>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <1b89eceeca92f7857d26c5d2097bea2bce10eb93.1787568944.git.gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b89eceeca92f7857d26c5d2097bea2bce10eb93.1787568944.git.gahing@gahingwoo.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfXxpgNXqA0cD4N
 Uc2JWIXaZ026XtXv6A6y0RfZlUg0KesFKwXv7oXAqzQjxZ1GziPKL5mrkxPRPrfrEG9AEYkfjbi
 TFOJkgL+Cs0eM0GFblvdOdWcbPs3ngE=
X-Proofpoint-GUID: R3uWTrpiiAlpq5w6mhQYElwYPIFq8UUu
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c2b83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=lG5QNMjPvMxfgh1q_X8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NiBTYWx0ZWRfX3rxrZXPoWjNm
 kb3FXpWAHKYLkH4YWt9C46VXxpqumfGLDtXIM+UP80ct9sVVsNdAspMy1yjkKRs9TssABqCGgeT
 YHPsFv3IEJvj5GKU7H1zLiywdMArIV7beSEiNdk1TV2V/BAaL/vFgmJ0uKRYmT0K1y9XGnfbox8
 sqeea0xHiDght26gvuqy9hcCT2E2yt53amwT9Z14Mlo5et9YsjZZ0Cs8OWTEss//G95MQy2slI9
 jZu2/9G0VNevmCLcytYxspcNumFOuLGdeYJEeQposy8EhTqkgRcH1Dx+jJPaRIVmXp7/vBV0242
 NnDSKF45addHFOFO8DwJGh1V9btHTHDzvLH5KPV96GgNv0gVldZBII8TrNTObhDM5f6sk5TBBWB
 WQPr2hTUk62429RO/6dn/YAq+ziUL3/XzDXYU6479B16yC8hJuZQetg3T+QDIUnrVgzW0Ap5EOh
 jut9cejBHPkv6lF2cHA==
X-Proofpoint-ORIG-GUID: R3uWTrpiiAlpq5w6mhQYElwYPIFq8UUu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240096
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

On 26-08-24 23:08:57, Jiaxing Hu wrote:
> The RK3576 NPU domains need a short settle time after the idle request
> is released before the registers behind the domain answer. Without it
> the QoS writes that rockchip_pmu_restore_qos() issues land while the
> domain is still coming up, and the NPU throws an async SError on the
> first cold power-on.
> 
> Give rockchip_domain_info an optional delay_us and wait for it between
> releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
> DOMAIN_M_O_R_G_W, since the suffixes name the fields the macro sets and
> this one now also carries a wakeup delay; RK3576 is its only user, so
> the old spelling is not kept around.
> 
> While the macro is being rewritten, give it the regulator argument that
> DOMAIN_M_O_R and DOMAIN_M_R already take. Without .need_regulator set,
> rockchip_pd_regulator_enable() returns early for every RK3576 domain, so
> a domain-supply in the device tree is never looked up and never enabled.
> Add a DOMAIN_RK3576_R spelling that passes true and use it for
> RK3576_PD_NPU, which is the one RK3576 domain with a rail of its own;
> every other domain passes false and is unchanged.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
