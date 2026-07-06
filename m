Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D708EC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C24210E863;
	Mon,  6 Jul 2026 09:52:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k51dKZg9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dd6MTNDO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE7610E85A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:52:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669PqkT184125
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 09:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ymiCvoZUHnvPV3UZWE3h9gNLgtym4Czr4Iw523eM3AQ=; b=k51dKZg9OvEZm8mO
 V65Bh35rQB9pDW3pfKnt/YioF/TmIHOaEKTKmzXF2FoDqvSLG3JTaq82KuGMwVHh
 f9DkDecvTmnLePdBr4MEtws+tq5rkHGfeiNF9lXYum61eyxXAcRbOVv2Ve2n+JfJ
 me/L0UjjscMbH6T7acjPDd9gjG6/wiQTHBaMubgkhIpleQNmXLb+FZo2oKUmXn1J
 C5jWoA8Z6VCEr9ddCWK/axrMY4Djo6Afz9Tq06TK98pqlkhtLw0URo8+C6cZPSid
 9mhMD+SZQPiYIZBKwGDGRiEi6DBITGNoZMIW7Iqkfm4f4ZedsKJhLTdqw0UvAMCK
 LLvukw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpg3ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 09:52:24 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so4404455a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783331543; x=1783936343;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ymiCvoZUHnvPV3UZWE3h9gNLgtym4Czr4Iw523eM3AQ=;
 b=dd6MTNDOFoqPXUYv+y8xcahcIyJ7arpHlmWJPkt2dscYt3Z8H4r+dZ0SaZ7gvUGxJh
 Tdy7mCiRDCoHQJLDiJpZ9RWzASY5D1SI3aaBGdkyyPDzyIr7GRenwOzO4tGNKyRq91cb
 X/5fGV2voixzuWeCrvNZoI8ZhQxQLq87KSirHI0VO7bbJGtwMhz1qYviGsHkiv49ORP8
 D+dO0v6RCqspSXhnS6/QG1URYUGTDU72G0ntIAQMYvxe/hyL2NE362CAqrmQUpVaFdOi
 /nVNb1IGuMDVex/e61wHpgXziUQSF1YLqvCFKnfCIaRHpj4S7zKSKPsXmSGrZ4QtoLKh
 kaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783331543; x=1783936343;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ymiCvoZUHnvPV3UZWE3h9gNLgtym4Czr4Iw523eM3AQ=;
 b=fegjZqQ4kCsacDyPMqS8vwmrLlhcWp/JOhSeEZe4Z7fk5I7D2V8g8KabUzHg+fiDZw
 Fyqb02HomHRzSa5de0/tIkCTkcHDivWtD7Rfkf8DlVOXaGco8QkUqrRn1fqcBwHCn439
 PazxXZor9yWRvvCVkaTqPueOYFWLCvME3CA2l7vaA34EGSq+B3XFaoMIbZF2/4H16+F5
 LFv+nh8Lo+WYaAqabVc2hhPP+nUAq0SsffnIizT3nCrXVcvRkh1ND9OJem6o+dOtTp5L
 AA43cdV39c8/nzEblbzJRrY7gTtx/n5dizh3zHtsbiXNZoOqZaCH0dgDHRSsZEX5cgsB
 13dg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7N8ElDPFd8KkWgW1DjWGGPsq4JV9ACQsVtZxLDsxudIXzH1sr+tXPtXcgSH44Yf2loqC/EAYpwKM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0Bgs8GaqZQa6DRzr+N1MEYSyqVpzcu1/NZiGlkZyQ10exEYT2
 cL2TxrwNQ2MJzuhaIg7EIPHOc3mqFY7n8wc5ovyrgwO2JTwMXxoHByUtECAfFBBna3SolPBAAmp
 6EHXLmUgdtvUSKPO9KL2e4mHirKRbwhC7EFUS7fFOaXPKjYyZkiv+g4KygGUsv/sOp+VrSTY=
X-Gm-Gg: AfdE7cnv5fYt9lSdgL8Lqit7y/OUmMyIkMRPKgesDNx5V18GaI4gkLkRWRXuTuEeAK5
 7XjRCtfVEE66MY5KlyQPVER6VlMuiFEt90vuftBl0qE1SyrAiNPcCjJm617OHFs9IFAr3asZlsg
 svlK4OeEto1CTgWRx5P5irMbhkSe2bqeLckASzGSsD5vWY1ZmIVx6gWmtpMBwJOP3QhLn73qCZx
 S9LqD3xMg4y47vaQ8IKCd6SHVH2RjXLiUp02sX+0LfYH182jeZ9iKbv3eRcIn4KA7IFLGYwfQM5
 8ByfcoL3LQRpw/osP7HLhuLx7VNNEJ6cTeNe9OFvauvtlbFVXV/IvRSVF8BrAf9yCXQcyi5nD+s
 grVoq/1+FxArovxEgGJ9D8g6qr/H1yNTnSEvG
X-Received: by 2002:a05:6a20:72a0:b0:3bf:6c08:4ec6 with SMTP id
 adf61e73a8af0-3c03e52c6efmr10345057637.59.1783331542219; 
 Mon, 06 Jul 2026 02:52:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a0:b0:3bf:6c08:4ec6 with SMTP id
 adf61e73a8af0-3c03e52c6efmr10345031637.59.1783331541747; 
 Mon, 06 Jul 2026 02:52:21 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a1bsm52826858eec.3.2026.07.06.02.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 02:52:21 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:22:15 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, neil.armstrong@linaro.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vishnu.saini@qualcomm.oss.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Resolutions broken after "drm/msm: dsi: fix PLL
 init in bonded mode"
Message-ID: <akt6z1irWlXA5UIy@hu-mdsor-hyd.qualcomm.com>
References: <20251027-topic-sm8x50-fix-dsi-bonded-v1-1-a477cd3f907d@linaro.org>
 <ae07cef84AmXK43H@hu-mdsor-hyd.qualcomm.com>
 <wrhuksrzlxw2pjlvjm37dwjuztcv7qs5t6mqiav4ujecwqdkwj@ozbfxpbgaimt>
 <CAJfMnmEVwUwt=wMJ-8HKH1yz9+erWLrRGB+6wVYCdSGDK+_T_Q@mail.gmail.com>
 <114b9be8-1fca-4762-822e-1d53838d5de5@leemhuis.info>
 <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <o64cxeq5f4ffqpdmbai5cvsmxei2cnw3p6acvu55xl3cj5w3z3@6o6kokszvng7>
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4b7ad8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=X_DaoaUhr7fqxi3pwtIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: jD-NKz-FD8xOQDKSHUo02ToWOzq04Ztm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5OSBTYWx0ZWRfX+Q9dzabYZe5Y
 OckIKTdPKI8D1il0x4NjBKas7EugOgryrhkQMJIHxCeMwh7c8gP3oB2O9l5fHwJxtQzROGr7Oqa
 paTKq4sFxFcuUg98CNcb8xguFlXhQmZh8EgPZqKPq20sAkiNOPqox0iBrhzQDHMzQmcrxKWBh7r
 FzRzZvH27HthdfRQE29/4g2SszN3pG8954Dd1JpOAGuROPVSw6ACFSvR56O34VO6O63FLzk47Qb
 LUH7WSJXSNnhH/uKAY/xeIhS15BI3V1+GiQmcjmDlNUGBgsUDbPYUnfQccm9AitwQnPiwQ6HG24
 uL+WtF9NQ9O5vXpLF6Wj35M7nRKO3/HGpT9xwznhxBW7f6uTnV1xlXnUs4zB5H05i8W3/YKWXef
 pdg+KvgsuFd7X5aMTPCsXA+o1vmXDd/OcyqZrBz78EBTSJgY0gB7JuNPGfIGWuJsyYcXFOoGfDC
 vFxv5mj3OFQ+/niP/gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5OSBTYWx0ZWRfXxlRKl/OEOdHV
 stFJBUocuXXJ/SNmC4F6d6iX9mkFwPMcvNnWOW9f1l799P4fFdW/TcCiRtjl9PtPTp/nLMKcDYd
 2d1TO+oAOW4c3IKHatpoCNiVW6gRQRc=
X-Proofpoint-GUID: jD-NKz-FD8xOQDKSHUo02ToWOzq04Ztm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060099
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

On Wed, Jun 03, 2026 at 03:11:34PM +0300, Dmitry Baryshkov wrote:
> On Wed, Jun 03, 2026 at 11:56:15AM +0200, Thorsten Leemhuis wrote:
> > On 5/4/26 22:09, Mohit Dsor wrote:
> > > Sorry for the late reply. I am attaching clk_summary and reg_dump in
> > > working and non working case. Lilliput is just a normal display working
> > > with hdmi and has 720p as preferred mode. Yes, I was talking about RB3
> > > Gen2 only.
> > 
> > Neil, Dmitry, and Mohit: what's the status here? From the outside it
> > looks like this regression is still unfixed with nothing happening for
> > weeks now. Or has progress been made and I just missed it?
> 
> Thanks as a reminder. Unfortunately, it takes some more time (and I've
> been a bit overloaded lately). Worst case I will send a revert soon.
>
Just wanted to check if you had a chance to look into this issue and whether there's any update on the investigation from your side.
> > 
> 
> -- 
> With best wishes
> Dmitry
