Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1BC107BCF8
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 09:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C1F310E138;
	Sat, 14 Mar 2026 09:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P28Ozixk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14A8B10E138
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 09:01:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F1197405F5;
 Sat, 14 Mar 2026 09:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C096C116C6;
 Sat, 14 Mar 2026 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773478904;
 bh=3un0fWnRuKDl/f/T8R1D28aJLdNp3WGmfmnjwwjKUOA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P28OzixkGBKvfoAsS1woDY+WKvW5nIdpHY8IX0vCUArlyvkZZEs8wC8eIC80Miis7
 D2f70Sv5zuwcgODWpuMlW0II+znhLawrIF+9s6yhQtqNKmJp5A4x29G8KskNEOPdMl
 ZyJHNFO2smhPaeCFRsHvhousAwrq7lHtYnHjIfM7dREGjvePqp6Vh827Vb0QlGOlmI
 l2spjrE26+X5X5eRI/g9SBwxAXQLOWlul4Zxt6dtNmzqeCZrB3GWRyDsXwaf47VynR
 +3hyeo6HMgJHV6Mun73BuySav99ZgAiov36i76TMS+7c7Efzcjq5djdT4rfSnGBLXZ
 CPa1TRl1PTCVQ==
Date: Sat, 14 Mar 2026 10:01:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com, 
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
 konradybcio@kernel.org, mathieu.poirier@linaro.org,
 linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, mani@kernel.org
Subject: Re: [PATCH V5 2/5] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Glymur CDSP
Message-ID: <20260314-dashing-screeching-swift-ed0d1e@quoll>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
 <20260313120814.1312410-3-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313120814.1312410-3-sibi.sankar@oss.qualcomm.com>
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

On Fri, Mar 13, 2026 at 05:38:11PM +0530, Sibi Sankar wrote:
> Document compatible for Qualcomm Glymur CDSP PAS which is compatible
> with SM8550 SoC except for the one additional interrupt ("shutdown-ack").
> Similar to the Qualcomm Kaanapali SoC, "global_sync_mem" is not managed
> by the kernel so it remains unlisted.
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

