Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD24606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmGCEJUf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1275610E117;
	Mon, 16 Nov 2026 10:05:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D631710E117
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:04:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A427626B4;
 Mon, 16 Nov 2026 10:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36011F000C5;
 Mon, 16 Nov 2026 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794823493;
 bh=nWbqV/2GgvrCv1bHqZ+LVKd/sYtL0RqidrX2JSrXj94=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=SmGCEJUfFitU+d0elvKkqVrw54HlBbcB29j78bP0CsUwsAbWRPluoXK30w+hamf1Z
 02iKBkoP1WFXp1jrAkpJzv4jLBiLuaArvLeoKfbySw2ab9PG6uFjPCwc5Rmhn21Eyq
 sDctT6Ct086veH0ivfHZSjabY7totIx8CNqZr/IXMR0SRWZex9lqDFQTfpqr3+Axkc
 7+fbaM/FJYJpvx5jH802a3RoZdU6SOU9+fQCDdVDmpn+ToYavESLd4RsuU8TdEkvpJ
 hgbB911M+qmNDO4+x4xpOHuPqEm+WgGRIP+zWX8Vpe42SfuMPTW1ZdUIZ7hHMpVPdk
 aquj6h/KexujQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>, 
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
References: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/3] misc: fastrpc: fix ADSP duplicate session creation
Message-Id: <179482349066.14925.18435181444934097603.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 10:04:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 02 Nov 2026 14:01:01 +0530, Vinayak Katoch wrote:
> For ADSP, only a limited number of FastRPC context banks (CBs) are
> available. Each CB supports a single session, which means only a few
> processes can run on ADSP simultaneously. If all sessions are consumed
> by fastrpc daemons, no session remains available when a user application
> starts, causing the application to fail.
> 
> To work around this, some DT set:
>   qcom,nsessions = <5>;
> which duplicated sessions inline during context bank initialisation.
> Upstream feedback indicated that this policy does not belong in DT and
> should be handled at the driver level instead.
> 
> [...]

Applied, thanks!

[1/3] misc: fastrpc: iterate CB nodes manually instead of of_platform_populate
      commit: 81b3908cf7b9b19a8a47521a18281399c55db889
[2/3] misc: fastrpc: move ADSP duplicate session creation to the driver
      commit: 112dc91edd51e964351513d876c2e5a63cbe980a
[3/3] dt-bindings: misc: qcom,fastrpc: deprecate qcom,nsessions
      commit: 641dd7dd0f68dacb8e972aded126887c17d6cf37

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

