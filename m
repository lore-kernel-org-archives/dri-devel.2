Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C675BCDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2909010F326;
	Thu, 25 Jun 2026 16:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="du3kcfJz";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305B310F319
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782405375; x=1783010175; i=deller@gmx.de;
 bh=2ZEHUpFpeV+yRKzAOHPL/AmarR5vmtxFqVpB3wLdpzM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=du3kcfJzr9CG5HmvUqsE1PGLu/j013aJTLtOrpK6vJe+VUoBl3WwCDCbFB+D9vkl
 gwKIYUhtEOpmh4IYmeu8Nh7VwvhRiEP5RtPZBb82P9/olun3K46qSBtbZ8nH6AYiW
 VIa1+8CefswSq8/xTwVU7HTClWm36jKXgfl4gpZGUgbgi9+lAZH7ztZaNjoCQNB1Z
 +8bI1N2Mpv+voKqa+4kozyL0BvGUlqwo8e77oiahItX38g9L8iG7mVTCQBSjy+BIX
 elw3lUO0lXlIjuem0DFClflnAM+xtULVNtVYbhKg9TvXECi2tEYM8gB8nnxvhZoTp
 XwMyCDS2pvQ4Xz0eZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1wUIrk1aZX-0049YJ; Thu, 25
 Jun 2026 18:36:15 +0200
Message-ID: <680af3c3-b4df-4e77-8cf1-b9f635efc563@gmx.de>
Date: Thu, 25 Jun 2026 18:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: via: return an error when DMA copy times out
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624144313.79291-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260624144313.79291-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emRdTGrIL6CmZ/Wk+AEvNqRvRy9SA7Vqxfm3PNxJ9X15yGMt86k
 FNQ3CJ39ACsBK5YQLVZlSaFW+Wmsmj31Mlq908aIrxqIvmGCmuXxn0ioVTbXvL16OPZ3gV3
 mjdjkSu3FpamYvabR3z0yWXzW74fWrKjCSMlH82vdVDc9KYYH3VClu5LLOi+4i2Hbm95eKJ
 KQEIJLotMCQrDf9JlIkSw==
UI-OutboundReport: notjunk:1;M01:P0:Rz8t9ALRWak=;8yIqw7Va0S361I3pyB2q0gR583M
 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
 9aqGz4Cpl65LYJ22m9puwPj+ct0=
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

On 6/24/26 16:43, Pengpeng Hou wrote:
> viafb_dma_copy_out_sg() logs a VIA DMA timeout when the DONE bit is not
> set after the completion wait and grace delay, but still returns success
> to the caller.
>=20
> Preserve the existing cleanup sequence and return -ETIMEDOUT when the DM=
A
> engine did not report completion.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   drivers/video/fbdev/via/via-core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Note that the return value isn't checked by the caller.
Nevertheless, it's a cleanup, so I applied it.

Thanks!
Helge
