Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA3EC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4AC10E012;
	Wed, 16 Sep 2026 09:54:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="fINTCHd2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTBEJa4S";
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C72410E8F5
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:53:58 +0000 (UTC)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1789552436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gU28K/TBmhCpoW3RpgGeEwSRVwR0d59zct58qf7aOmM=;
 b=fINTCHd2rV5qr8hjmNiqsQ4kOatkIK9D9rw4UdLHoz2bQS/o6CllgkB3r7yfaRgZ8h8A/N
 9ZWUJUXswF3y/wEMSvF97Bcyi5ijZpITTAFGs1xKXXZUn6JgFMLlQ4HY6hrY8Ak4c4wJ1R
 HdOMPTC+Fm9QLPckwARGA0qcR6vSsJYONMDfHSOc9mAKt/0ceLsusKTE2zkREdEMfFRZax
 VMAvNojX/ixR/MKY2wJiCqMZPv/zodO4iz8BgAN/6Q4H0UdFxOgNCoeYOGhE8CyFNDoyja
 MGAcIOtkkok0yiGfD4arKl5sEkWhUsHG9KFJwKsp8HRhSCLSOq9a3W1lZ/ht6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1789552436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gU28K/TBmhCpoW3RpgGeEwSRVwR0d59zct58qf7aOmM=;
 b=XTBEJa4S1t4j/hKUlrlaaDS2takijVXH7QjcDoSKns0Jg3CN6SgDUy41SQB8W5H5heoKF3
 zNiHzB2t8we1GiAg==
To: Omer PALA <palaomer100@gmail.com>, andy@kernel.org,
 gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fb_upd161704: replace udelay with
 usleep_range
In-Reply-To: <20260916093928.52057-1-palaomer100@gmail.com>
References: <20260916093928.52057-1-palaomer100@gmail.com>
Date: Wed, 16 Sep 2026 11:53:55 +0200
Message-ID: <87ecet5xos.fsf@yellow.woof>
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

Omer PALA <palaomer100@gmail.com> writes:
> Replace udelay() calls with usleep_range()
> to avoid busy-waiting and allow the
> scheduler to sleep during delays.
>
> Signed-off-by: Omer PALA <palaomer100@gmail.com>

This change cannot be accepted unless it has been validated with
hardware.

Btw, I am curious why we have these udelay(). Can we remove them?

Nam
