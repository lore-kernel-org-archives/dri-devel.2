Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE5FC61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 09:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CE510E16B;
	Sun, 30 Aug 2026 09:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bgzta3yB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9574510E16B
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 09:50:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 882F8600AE;
 Sun, 30 Aug 2026 09:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7461F000E9;
 Sun, 30 Aug 2026 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788083437;
 bh=FYIfK3uTkNCT+KVZTnBM/k5ekM0A7fNCMCiGAvjFqVQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bgzta3yB5Kc4FdjDdpPuSyRmToIgrAt4Cn/vsD2/opxxWp6r17x0Ciz8B96v+yuPn
 9ttxB9scgLD5vFo+TazrVVI6kZBRtMhhAzcdtEGsXoXadOftOOZCevSHlNMvO32HW2
 /a02G/FsEqsRm/9zTUs7dREtKHpqRtWIGqeBHaYiVQK2AkJ20MsD9Z6vY+vJToLqjh
 mu/matyEEx9hsMR/UrK8vZfS0OKIOQB1SxQbSwRlVij4LSHHXzlBI5Rtzp+5nQb7lB
 8GmOBpbgrpCRQJD165QpyiTUsNem2oU2JWeaB2C/sbc6OMNIUyAf4HosHJxP8osAv5
 4LiBgKvz6fupw==
Date: Sun, 30 Aug 2026 11:50:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] misc: fastrpc: Add extended IOVA mapping support
Message-ID: <20260830-hilarious-controversial-boa-bbcb1d@quoll>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
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

On Wed, Aug 26, 2026 at 07:15:42PM +0530, Vinayak Katoch wrote:
> 
> - Two new UAPI flags (FASTRPC_MAP_FD_EXTENDED and
>   FASTRPC_MAP_FD_DELAYED_EXTENDED) allow userspace to request extended
>   mapping. When set, fastrpc_map_attach() iterates cctx->ext_cb[] and
>   retries on -ENOMEM, falling over to the next extended CB if one
>   exhausts its IOVA space. The SID offset is corrected per-CB so the
>   IOVA forwarded to the DSP is valid.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
> Vinayak Katoch (6):
>       dt-bindings: misc: fastrpc: Add memory-region property for context bank
>       misc: fastrpc: Handle multi-cell reg in context bank probe
>       arm64: dts: qcom: kaanapali: Add CDSP FastRPC extended context bank
>       arm64: dts: qcom: glymur: Add CDSP FastRPC extended context bank
>       misc: fastrpc: Add extended context bank support
>       misc: fastrpc: Add UAPI flags for extended IOVA mapping

DTS must not be part of misc posting. Please always split it.

Best regards,
Krzysztof

