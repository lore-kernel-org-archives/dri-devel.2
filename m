Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIY4tUO1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E25610E657;
	Fri, 27 Nov 2026 11:16:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB0310E9DB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:16:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4480A42346;
 Fri, 27 Nov 2026 11:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E65A1F000C1;
 Fri, 27 Nov 2026 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795778207;
 bh=fB7AjFVZA6hbz5yhYMWpLKE+61Bh8LA6GXONV0oBnoQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=XIY4tUO1iO0N32nF41SaFX0FIU6y7qPj6l70Tt6nM/g7+oLvmYkrb91Uevtu+WCmj
 yIfW8C25SimZgk8ajwJ2Muc9vHFBHhy2r735IZ2nPpMRe7r/VRs8J42H27+iZ6j6hU
 A+kLRZtftiX71CqtOKRFCTiZuPGcCJ94zpnI1F9TMFeOsTo6jHqyzVAi69xshb5//T
 3RD/49TUr2Vcnqw/kotrkkbhi9b//upK1Zapysi4jY64uPmMVRjo2E8f0KczQcub87
 x5AijSqlA0CZYbM3gw4AZg12HVmV6W6l2zTmVwpVulO2aOehvTeHNjSaVmHskUWmQX
 W07k/yVFr6Wgw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 11/11] phy: qcom: edp: Add Nord eDP/DP PHY support
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Nabige Aala <nabige.aala@oss.qualcomm.com>, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org, 
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <sashiko-outbox-217102@kernel.org>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-11-e3d3bf0e2c49@oss.qualcomm.com>
 <sashiko-outbox-217102@kernel.org>
Date: Fri, 27 Nov 2026 16:46:39 +0530
Message-Id: <179577819984.3421.10994547159567052994.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=366; i=mani@kernel.org;
 h=from:subject:message-id; bh=jQnuYXuOAGsc/lzQqiz8LyDUtWXDdDYLB1ApE7FX+sg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrCWaaP9QzsWS7L+SR9mqpkFBIMdiU8H5U6S7u8
 Ayi8Ul/dVOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawlmmgAKCRBVnxHm/pHO
 9UTGB/958CXL27cfYFEPvCQkV4ejUdgILBa76IhDFzPccjEAma9Kve65f1WKJDlT4Jdnn+cI+xJ
 I3TUCAZPwb97pM+BrQqDC4p0LGWWwYOQP1tO63gTTemNWOKGFlgAIgNzy1PqsMtQN36O4C5hpzB
 2ILrqAPXofSxGXZaJzAEvUFQK3NGBuqbjSATVGeRUkAw1wvr4kJRihbwAdxCYxR9mtLlRaZkBiM
 5JiVUh2ks8oDd8RMNvny0zVOsDfgiZDTwzyfcOrbGWxHX+s/weaFxju9DqPS4rFjEpycv6Ry104
 3WBiNo0WjFEsWu7N7ANc0xjECW9aKve074OCPFxGXJpKUHBa
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
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

On 2026-11-16 13:44 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Low] phy: qcom: edp: duplicated v6/v8 definitions and misplaced Nord
>   code
> - [Low] phy: qcom: edp: asymmetric DRV_LVL writes in
>   qcom_edp_tx_res_config_nord()

Both are fair concerns.

- Mani


