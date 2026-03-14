Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17CF107BCF8
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 09:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3741F10E0A2;
	Sat, 14 Mar 2026 09:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BfBAuSv6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB44B10E0A2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 09:01:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 71C3440267;
 Sat, 14 Mar 2026 09:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD96EC116C6;
 Sat, 14 Mar 2026 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773478881;
 bh=pBaaXeu9/QXt2rXgK/g7ZRMeYiCZNValiF26uuS2oas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BfBAuSv6vxRq44BmB3CzXkjxAsS3geeYNSuPbBisMIy0ye5AkK5Vv+fPMoc5yF66m
 JeanQNrLtCMYrt00OHEhIIv+Oqn7HEjVR51d8WWplydz1jPOftm+SRYSPcjR9mIFm9
 Bt85TNZNGlwL1jGpDvl+NconhfzKtvEOh1ViG/prVstsr16bH+C764pUwI+/NrXPq3
 VfppXW9dKaUriD8ryLSyexlta6sB4yX5t7PQruK9GJCa+T4+EbyZ+6bqC/zEeWOuOP
 E1UYgmQwU7Hvn4DaWrdYrJFvTvqoEz1k0jJ6FMrKS3/PAlMPFb9yjctKC++qyGwia4
 +Hp4bTiFYxI9g==
Date: Sat, 14 Mar 2026 10:01:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com, 
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
 konradybcio@kernel.org, mathieu.poirier@linaro.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH V5 1/5] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Glymur ADSP
Message-ID: <20260314-dynamic-terrestrial-pegasus-81c507@quoll>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
 <20260313120814.1312410-2-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313120814.1312410-2-sibi.sankar@oss.qualcomm.com>
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

On Fri, Mar 13, 2026 at 05:38:10PM +0530, Sibi Sankar wrote:
> Document compatible for Qualcomm Glymur ADSP PAS which is compatible
> with SM8750, which can fallback to SM8550 except for the one additional
> interrupt ("shutdown-ack").
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

