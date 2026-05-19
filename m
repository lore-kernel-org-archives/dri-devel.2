Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A610ACD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17F0410E3C4;
	Tue, 19 May 2026 16:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jcc7OVoE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3175810E3C4
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:08:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A81060207;
 Tue, 19 May 2026 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D66C2BCB3;
 Tue, 19 May 2026 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779206906;
 bh=JMaW4hqrbwsNQNbegT85fZ2gaCvhjDdo60FQavqvwXc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Jcc7OVoE3JRnYMPKGDgL13sAzYMamlppzuKhImtT2XkXF0Tg2Bo15E+lBJPGiMemu
 b/K1uvbyFruTC0SmamOWRLmzIaUQBAAG1sWjjYxYWBdTkqtxS4h9ePVRDY2fh3z4I7
 cXZaOdk3+i7TVEb9R+6vKR5vZsMycXkBlyF64KzWL959fxCupb+aL3Jw3Utbz+UuuE
 wxc/htWIIy67A8e1Ym+KHfUZjDBpjYGbUUAD6wL8bUZ5wdTPiqIvV0M6O7dANppS3b
 75epNqq6FrOD5ztTgqMdD/ikNuJw0U/yqgpQyKqEpPeXrSQ++36W19vdK26lgTcjpU
 DM8NTcmSDgsNw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Escande <thierry.escande@linaro.org>, 
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
References: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] misc: fastrpc: Fix NULL pointer dereference in
 rpmsg callback
Message-Id: <177920690436.52506.3867617056043903009.b4-ty@kernel.org>
Date: Tue, 19 May 2026 17:08:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Mon, 04 May 2026 22:47:00 +0530, Mukesh Ojha wrote:
> A NULL pointer dereference was observed on Hawi at boot when the DSP
> sends a glink message before fastrpc_rpmsg_probe() has completed
> initialization:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
>   pc : _raw_spin_lock_irqsave+0x34/0x8c
>   lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
>   ...
>   Call trace:
>    _raw_spin_lock_irqsave+0x34/0x8c (P)
>    fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
>    qcom_glink_native_rx+0x538/0x6a4
>    qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
> 
> [...]

Applied, thanks!

[1/2] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
      commit: 4d24965e0ae82ae4b49c4d739d030ee23a1779d4
[2/2] misc: fastrpc: Move prints outside spinlock in fastrpc_cb_probe
      commit: 8d712bcdd1ef73bf790f01039508fb4e9c076bb1

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

