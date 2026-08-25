Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5D9C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F1410E96D;
	Tue, 25 Aug 2026 08:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="OqrIPmrF";
	dkim-atps=neutral
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F41E10E96D
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1787647634; x=1787906834;
 bh=Od7IsANHp9XzoW8pEczlbQg4ofXu9FbMG+Auow4vD0Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=OqrIPmrFd5TsKtZtTQEF0oWcxPk3Lpn51VrrN59DBWzACZjfT66DA5rr9npX3EuE+
 gnovSvhnVE9iUZe9VvzzUu+ib0uqI14i5kFm/5zGXr6aBtuQl2B5g3oBGetHtGAOXY
 GlonY0XLLxNXZ2z5cD4r0IMpoXB0InGi7BqPzEfYOncPoRpgQLH5PPlc8JzDPW02wI
 HhVYxpaugKl4r8njtZhSvryoiFhqKqQ/BJP15TCQKdBWwzYOHcR/XkBp3jco3Agf0/
 Y7CwfSOeLzpnvcfv3EvNUP/zDDRLnzMUGKlUNcM83Hhi5s6oo3+/dYAKrU/B5JSVxe
 kqLAP3OR1huyQ==
X-Pm-Submission-Id: 4hThH52vKZz2Schg
From: Esben Haabendal <esben@geanix.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: <dri-devel@lists.freedesktop.org>,  <stable@vger.kernel.org>,  "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
In-Reply-To: <2f0fef87-4377-4a01-a210-8d55a0b67a9e@web.de> (Markus Elfring's
 message of "Wed, 19 Aug 2026 13:51:13 +0200")
References: <20260810-ti-sn65dsi83-fixes-v4-2-ae9c95c8d162@geanix.com>
 <v45WZnbABEcVZHxTpq2Cw_Z3nnj7uSdSYEP2ANyYM3ZcoriX3BBSBRNIHGm_hNTsSqq3z35ZJLXTpuREP82q9w==@protonmail.internalid>
 <2f0fef87-4377-4a01-a210-8d55a0b67a9e@web.de>
Date: Tue, 25 Aug 2026 10:47:12 +0200
Message-ID: <87se42oacv.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

"Markus Elfring" <Markus.Elfring@web.de> writes:

>> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
>> callers has a chance to handle the failure.
>
>           have got?

I will change to "so that callers have a chance ...", for proper
plural form. Thanks.

/Esben
