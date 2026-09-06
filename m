Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E13C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914B110E669;
	Mon,  7 Sep 2026 07:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ADN0Hpb0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tK5hpGrs";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC8210E33A
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 10:10:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hd5YZ0qKqzKn0p;
 Sun, 06 Sep 2026 12:10:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788689426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gmavWPxJ0YZ4NW0ZmD41A7HMFxKRQWKCsJu9tg1FJk=;
 b=ADN0Hpb0kQnSS+XudT97KWXdxFi/YQTSIZCpwgr9UEq63kcHGgMpqXd4ZgQpnar+8tqVut
 SIZ8Ca7Jw3hhdXDU4CkGlHZlgW8NpM2VKvlRSZGr5VrMOATfhlHeF69Vts2ZnKk0vPxoHM
 pwjL4t86kyD4I4oEzTyYEqSLlt1tt9mL2Wm7TSuRz8sYVAqe/ZrAG08lJlUFCwFgJn5204
 TAJZsSAs7EVy6Wa29m46PiHaOnizyeGrD11DrRE5yZXBh0m+aIm/uZJQykbeYOqI/13cHj
 Ms9K0RyNME7QzME1/kaJrLdtfwCsUKvtJzJNe97vGDeRfARl9ynQoReUoiVm8g==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788689425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gmavWPxJ0YZ4NW0ZmD41A7HMFxKRQWKCsJu9tg1FJk=;
 b=tK5hpGrsytlfnLcuqxdSkO3fHJyr700MaMjmLzAe+LE0eLhzoxdpT+lFpK0lUHFEOeXZhN
 T639tZlmzW9McAC32oboBD7XWU3bgYYIshbBzh17gdzcJNMbSVNbhHNvaE4BDIGXE1FgVv
 zR3XVSRkorgnqNYcR2wvRZ2o8+L4na1CpnNzO3qAyQR/JuA3PF1jAUTm8ses42OniirnaR
 KxnHhrEuzW8yBDZxo2ZFcDFfnCj0MXu70t9TmH0DyYpXOiYk1/hpnTtzGzKy8ktqq3Ttka
 JUDlg68UdRT+DKBa9vXoKZr53RqrtkcIUK7tRXIK7n++HOPtM2p+0dlqd8kE5w==
To: torvalds@linux-foundation.org
Cc: dri-devel@lists.freedesktop.org, kees+treewide@kernel.org, kees@kernel.org,
 linux-kernel@vger.kernel.org, manuelebnerli@mailbox.org
Subject: Re: [GIT PULL] kmalloc_obj() conversions for v7.3-rc2 
Date: Sun,  6 Sep 2026 12:09:29 +0200
Message-ID: <20260906100929.1118270-2-manuelebnerli@mailbox.org>
In-Reply-To: <CAHk-=wg2B4maExxSmm6eO1aw9VGyK=Twswwb63Fdm6=KiOZbTw@mail.gmail.com>
References: <CAHk-=wg2B4maExxSmm6eO1aw9VGyK=Twswwb63Fdm6=KiOZbTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d6081351a96b2003a74
X-MBO-RS-META: efx8ntf6394bra1ffes5tndets53qesn
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

Could I please get a Reported-by Manuel Ebner <manuelebnerli@mailbox.org> tag?

Thanks
 Manuel
