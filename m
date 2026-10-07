Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978B8CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:45:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E7410F7B5;
	Wed,  7 Oct 2026 20:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oPjl4Jhf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBF610F7B5
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:45:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 568F242E29;
 Wed,  7 Oct 2026 20:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A51F000FF;
 Wed,  7 Oct 2026 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791405957;
 bh=AVegChHYiynIab6dcXIXFIdgk0jYyjoGPcciAkCI0pY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oPjl4JhfWgrA/wCXmKOiJ+6y4DmN7jFL4ndbb7AzkM0x7WjR3TJQk+upifxUqt16C
 rU7AxnWM2Er8iF6AMDEYfAFnHQ2unwCF/kwDVh4BnIG1PK627UQ1K2Y5eumBJRYMd2
 zTOlXqIShWnGKswMK1HvK3jY4BYdRIHdrPB4udsHePsj+ICBjRuk7krytkuCwCgsAX
 /wUSj8WstX3kSrj6Ix3jQwedl/QHg7YCOB/QZ/tlqTM/GH8W9t9xPYR6M91JZSrruU
 AyuRrbLkc+cC5BKaAjg0O2NY9TUsdck9tEfLf3NEKlHywn7GXPjO+XnLrHHjv7+QQS
 jm7wSQLzZV9DQ==
Date: Wed, 7 Oct 2026 15:45:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srini@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: misc: qcom, fastrpc: Allow hex digits
 in compute-cb node names
Message-ID: <179140595600.238028.12326483402772161970.robh@kernel.org>
References: <20261007-glymur-dtfix-v4-0-31f7143e759b@oss.qualcomm.com>
 <20261007-glymur-dtfix-v4-1-31f7143e759b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-glymur-dtfix-v4-1-31f7143e759b@oss.qualcomm.com>
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


On Wed, 07 Oct 2026 15:51:17 +0530, Ekansh Gupta wrote:
> The patternProperties key for compute-cb subnodes used [0-9]* which
> only matches decimal digits. However, per DTS convention, node unit
> addresses must be the lowercase hexadecimal representation of the reg
> value. For compute-cb nodes with reg values >= 10 (e.g. 12, 13, 14),
> the correct node names are compute-cb@c, compute-cb@d, compute-cb@e
> respectively, which are not matched by the current pattern.
> 
> Extend the pattern to [0-9a-f]+ to allow lowercase hex digits, making
> it consistent with DTS unit address conventions. Also change * to +
> to require at least one digit in the unit address.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

