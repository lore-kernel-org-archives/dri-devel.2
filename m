Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB04C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBB810E22E;
	Thu, 10 Sep 2026 02:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=scd31.com header.i=@scd31.com header.b="ZVLzAZ4R";
	dkim-atps=neutral
X-Greylist: delayed 554 seconds by postgrey-1.36 at gabe;
 Thu, 10 Sep 2026 02:08:37 UTC
Received: from mail.scd31.com (mail.scd31.com [205.209.125.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B524A10E22E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 02:08:37 +0000 (UTC)
From: Sophie D <patches@scd31.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scd31.com; s=mail;
 t=1789005562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPTlFatxbnqCqBdnyDYxPS+gQfFaoRdqwdLHQi5jO0Y=;
 b=ZVLzAZ4RC8fSUuiOan9es7jr4+OyYMKfEEE4uQUOyG/TulU+9tyV0ZJ8+HRyY3z6yutBPM
 VHXYrAub9QxA1m6Y49AjtI4SqrcOpmqQuhLnkk1uJh5S9Bl76TO5Gcg3YDWVUAy+QKgzi8
 LSbyEo4mH3qIjEE7p53dYJu6XCKyJp5KlY7RlD/BSnMZGiyaFPQKvlzxyzCZMJZCid2rA0
 4DziuMbMkR9Pm76MB9MOydjfBTmrab7IHbS+WXT1QCU3aB/zsnt76ERRXsj+sWSrG1y7KT
 kFUrLCLqjVGoOyX7cL2n7R4B9zuY/V4CLywT9ZH/s3UnDA1HmVCp3AGdgvPNhw==
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/gud: Merge damage clips in full update mode
In-Reply-To: <8c592732-6025-4073-b075-0e3e6911c935@suse.de>
References: <20260907230849.31032-1-patches@scd31.com>
 <8c592732-6025-4073-b075-0e3e6911c935@suse.de>
Date: Wed, 09 Sep 2026 21:59:22 -0400
Message-ID: <86h5jxsw79.fsf@scd31.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello,

>
> Such state needs to be checked much earlier. Please set=20
> plane_state->ignore_damage_clips [1] at the end of=20
> gud_plane_atomic_check [2] if in full-update mode.=C2=A0 The damage itera=
tor=20
> will then do the right thing.

Thank you for reviewing! I've made this change and have tested it on my
hardware.

Sophie
