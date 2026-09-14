Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B462C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BA0810EBE5;
	Mon, 14 Sep 2026 08:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ncXo7CHY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEAB310EBE5
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:07:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C56BE436CB;
 Mon, 14 Sep 2026 08:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038FB1F000FF;
 Mon, 14 Sep 2026 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789373257;
 bh=jVifJ45NiGh/UkfA5CUOlUG1aFVFPbEnUx9LB4glQZE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=ncXo7CHYZGAJ3Q0U7Lry+mBUIPPRRV8AEXwniSpVtFeS6KTJRqlSAwzLy3gAiglw3
 V64/D+KAIzCLWIv+e4q4KsBRRKwX4/FHikee8iVv6bjTSBmFvqri6XCiULzJvdBoOc
 6R7zG0GKaAAdwzGIlbOReW6lx+N7HJhcZuc8b+P7bKDXHknGQGcT3OTdlHb7263s+7
 ZAIqtnDf0caoXY5tSzfWphm1BTANDrpPPQFF8hR9CniFDj4AczFodQsxWNehg2g1JF
 NY9PSaw3MrnUB/fmtNOcOd6I9JvdWRrqzMNvkyMcLVBA29jPtroaO6lL4lBgFqNUvA
 DADfv853TbxMw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
References: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
Subject: Re: [PATCH v13] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Message-Id: <178937325582.257763.3545375214126322609.b4-ty@kernel.org>
Date: Mon, 14 Sep 2026 09:07:35 +0100
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


On Wed, 26 Aug 2026 11:38:03 +0800, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Additionally, the current implementation allows userspace to repeatedly
> grow the Audio PD heap, but does not support shrinking it. This can lead
> to unbounded memory usage over time, effectively causing a memory leak.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Allocate entire reserved memory for Audio PD in probe
      commit: 9981fbe599e80d0fa264b714ebf14d8d80d9790a

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

