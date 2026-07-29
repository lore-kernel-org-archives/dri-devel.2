Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3164C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 01:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3A710E60C;
	Wed, 29 Jul 2026 01:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d4RUfxVq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XBIYLAwv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C982210E60C
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 01:41:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T1GoCU234230
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 01:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NDSoxv1duGPaBGMKLf96xEHj
 RxlgSZsqTyGauqE3y/c=; b=d4RUfxVqXMyvn3CnF/S48P25ZTC+Vd7T9pRzww89
 MuZLP2g2gEbVaaRrgKBwvVd0elSBzQE4YALB4TWAlIBwJXpWVEsHF5gyIa1Lf7q7
 0moH0eC+WKnBbOlENc69At8gzVUTekh8AJqzPL1hxpT3FGzQlgmKqeeIz6q6nDRx
 ve10pb8JWK/7+4/SO8uszjgrQq9x3pmuacZ8NpBRNE8M89RJPyy/A7205d9Xi/ZL
 EDWSBsuLklQMr0QVxESU5NHVdQ7KI3fppU473oLeRPLfYc31nk8BLIauKqZ1dbrm
 KsUZpNCYdZjt9Kgh9nve7tesONhjASYMIEy6y+B+3TfldA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq5sagdky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 01:41:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so512603a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785289297; x=1785894097;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NDSoxv1duGPaBGMKLf96xEHjRxlgSZsqTyGauqE3y/c=;
 b=XBIYLAwv1GRoDnh9wea8CxYfb768IucsN1CtypFgbPijJnkcOQj9zTg2vDgisH0+WN
 NHf1wIPZtpypmO2jae7t6ABVgHCnAdR3K7B207rOF88dOSFt6QZreOyd/+E5GHG2lmqh
 cZvCa0am+5Qlcv1Y1DysUVN+8gEYzWinwRrXdlFgiR/HaAJeOax0YIS+y/wlrDVQRpeF
 3MoSXLjcU5t1RKPPYZZTDZTcTeuAmn5i4vZtQiD0YBSW8rsw9akwQwzzq7lRNCvbtuTD
 VfZpYgHIiXQbj8Ps0QZ+pa5cMGVY2JaMv5mg1fMWsmcrrNrRyY79TtJwBMqyWYrMbcke
 zhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785289297; x=1785894097;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NDSoxv1duGPaBGMKLf96xEHjRxlgSZsqTyGauqE3y/c=;
 b=b7MhGzHaLVAeIVit8Bn2ZCo0uc8LEt0VzEho8wR5qVj1raDpIo8YhzOtkFxD0jcxRw
 12TwoVIVb3bbgL52/fD+NNCBAmArjvzLU1p9LeK/xnMLRBDSMgU7qe2MMLMqQXsntwpI
 AB+nqp59m/juMSUqoIQnSLtei2LQTdQKGkSUrCVLzYEosnh3CndoqDg0ohXWPi8GpIhO
 0nBvtIPFSyo9s2m1ay/ZsAG1XXS4qXF/oaGZ8pJ5a/muvscpGbSdD/JyeMINtbyB6TAp
 X0F+0OZ9NF3GnClwSQXXYb05s2uHfDq0wYRWWWODXmWWAaqpbiQNsHaKyk6+BWwv5Fe4
 AyTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVf2HprIMWny+WyfpFSDbkI/wa7jluHouZ3NwYq3S4mcKVWhtcxlh3EHw468WSQu5QLqw3DNptlSs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQxOrQA3e46Zu/5jwyhgERHWhTDPlhixiZSN4mlr9YKKyVikuE
 CAuI4Yle1+tydjkmAJzj9dKBW1ZDMiv0ui+csxjhhpzqF51kPJrhwN/Cjp/CNm7Mik/Gs6BT3aq
 rUfcMRuMWOsIfhGnjbB3Gh94oiCsXBViJZCBV4sZ5VHhj6tG+5/JfSW0CyBuqa/60oWIkMEw=
X-Gm-Gg: AR+sD10PXSABeGpWGYkeAqQ1qulRAor0lKpZ3JonkvxUe8mjy7bMNzv+/cLEAOrb0zx
 g3A08Xn0vg8Ar9OOcQu+z7ZwJaGAaK2I/sf6ZowHi3n7qcsH9PqSV2vlZ8CB0WsC2WKRo9KR4ck
 chDUaHQFPjgty0MDxSZoHmtSLvuNFzHPm0km9x/U31dstifQzvarqzIh1N3v595uxCR4FU1hgjH
 r2nmIaRBkEeS0TuSnUDHw/AsdVIEoIpTNfpEjnP+xJguEhRmUCZa0WNNe5Lw/CZPZNdC8if4P7L
 ShjMW74+Rfd1WgA9TDeR5/2sr0xEj9AQjgMYcYvx7lQz5vwCaMjtOvAETPcIxRgOaiITf1x0vGx
 OvbHtHnQ1b5GXAWw0m+z/Ds9OsCy7SbTy/QAb2urQhO0=
X-Received: by 2002:a17:90b:580e:b0:37e:1620:dabc with SMTP id
 98e67ed59e1d1-38f832a14bdmr429363a91.0.1785289297353; 
 Tue, 28 Jul 2026 18:41:37 -0700 (PDT)
X-Received: by 2002:a17:90b:580e:b0:37e:1620:dabc with SMTP id
 98e67ed59e1d1-38f832a14bdmr429344a91.0.1785289296891; 
 Tue, 28 Jul 2026 18:41:36 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d37368sm5981696eec.22.2026.07.28.18.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 18:41:36 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:41:31 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Drop unhandled DSP PD exit notification
Message-ID: <amlaS4fj_UMfDxKu@QCOM-aGQu4IUr3Y>
References: <20260728073851.682023-1-shengchao.guo@oss.qualcomm.com>
 <7761fab5-089a-463a-8de9-1922da2ff602@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7761fab5-089a-463a-8de9-1922da2ff602@oss.qualcomm.com>
X-Proofpoint-GUID: y9ER2tMJQky5jl_1CYIWzBUGINlr12tb
X-Authority-Analysis: v=2.4 cv=C5fZDwP+ c=1 sm=1 tr=0 ts=6a695a52 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=9GNMV6-CCpsCGH9bzfgA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: y9ER2tMJQky5jl_1CYIWzBUGINlr12tb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAxMSBTYWx0ZWRfXxiTOHAkZqun1
 Zqe4bRRs89Ka0gp3QixWJzOI7vmmegiIGcd1jykW757p/C5bmyL25cdEb5wIC4VMz5Xl2ceL5rF
 pZkGzyaoQLns0tRK8VTzCgA/MN2+21c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAxMSBTYWx0ZWRfX6t/xpHmrLPJ6
 ZKULu4MYFNtREMHprg0kIyAf7JKePPMZqwkzdjO3SUPZ+d3PA7GB5K6MSfiU1elu5ox9HR8Y/KX
 WwvHpa074+8VmaPNjMzfahDEJtgGUdhiKUuV6jJbQNnPE+wHgNPDZ0X08Gc26B2CXBniuzEF4Nv
 5n+npczGZCr2zU+y0lTfyUq1MkinnYHLadUXBBiNwWjisVz7+tKwjJoxeGANZhtJ+EnmxcbMhXc
 /qcVbnz1Uc7Zz2+Ddaoa8d+aBiqRvyA7yMZkADPR+U2ZRfTRMrVQezLxypmZitZ4rncrKO9pMjN
 JRuvSNd4MV2ihJq2JcgiAoH5FpyNNnwlHEPMClqigo299ZRwD24HJ/QZ5kBJXmvTieXLHTeQOVl
 h3cDb2ccWLHKyi2N9voLpFCEHvMIAbAgYTYhUujI03Hf2MDOf0Nq1Xzr7k1DT08lfMmZPn5U8si
 w9kJL+U4Hlkbu9ldYhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290011
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

On Tue, Jul 28, 2026 at 04:06:50PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 7/28/26 8:38 AM, Shawn Guo wrote:
> > Newer DSP firmware implements a PD (Protection Domain) notification
> > framework that sends PD state notifications upon request. The PD exit
> > notification is unconditionally sent by the DSP with a fixed sentinel
> > 0xABCDABCD in the context field.
> > 
> > fastrpc_rpmsg_callback() treats every inbound message as an invoke
> > response, so the sentinel is masked and shifted like any real response
> > ((0xABCDABCD & 0xFF0) >> 4 == 188) and looked up in the channel's
> > context idr.
> > 
> > This is not merely cosmetic. In the common case idr slot 188 is empty,
> > the lookup fails, and the driver only logs a spurious "No context ID
> > matches response" error on every teardown. But the context idr is shared
> > by every protection domain and the listener thread on the channel and is
> > filled cyclically over [1, FASTRPC_CTX_MAX]. If slot 188 holds a live
> > context when the sentinel arrives, the sentinel's return value is written
> > into that unrelated in-flight invocation and it is completed early.
> > 
> > Since neither the fastrpc library nor the driver supports the DSP PD
> > notification framework, it is safe to drop the PD exit notification
> > before it is ever turned into a context lookup. This removes both the
> > log spam and the mis-completion race. A genuine response can never be
> > masked: a real context is (idr_index << 4) | pd (at most 0xFF3) and
> > can never equal the sentinel.
> > 
> > Assisted-by: Claude:claude-opus-4-8
> > Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > ---
> 
> Does not apply to linux-next, can you rebase it pl.

Hmm, the patch was based on next-20260727 and still applies to
next-20260728. I pushed a branch based on next-20260728 for your
reference here [1].

Shawn

[1] https://github.com/shawngsc/linux/commits/next-20260728-nord-fastrpc-v2
