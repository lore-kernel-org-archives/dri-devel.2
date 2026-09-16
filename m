Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8F4C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C3610E088;
	Wed, 16 Sep 2026 16:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bYzLYrHc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01DB10E088
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:06:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 849E16020C;
 Wed, 16 Sep 2026 16:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6FF1F00893;
 Wed, 16 Sep 2026 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789574807;
 bh=V6myRgIiHLsDNbx9crxJAojk3d9Ehre3Gq3ESvkVIlg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=bYzLYrHcAMFPKNDCGqvw3+lfn5AYdsOwr4Cbm6kGzZtkA/AxDoXGrFNRv5tECDH5o
 xPxbiaDoJSO0e3O0eggkIHXqr0jRdHJoZQYOattwi+CtjLcIfrQYqJdrGsKjHHqzZ2
 V2fZsJUDDQF5vXWcPLf+wQjjFuQp+ThUGre6pF0aRuCjYghuBecPghfe6hJmhszdkk
 cKSva/GD6c4C/fNoopiezVhLm+NwR+ONzn2ky5wUQJLj+CIEvnAPrW6r5XqDcjnOhO
 MX2OEHbI4tkAefq7EzwFh25IX75Oi3PzD6hptDWEmtCt0GZDcFFYyViXoXxYx9vvQM
 qmq2Gi1ay9VBQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Linus Walleij <linusw@kernel.org>, Hemanth Selam <hemanth.selam@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
In-Reply-To: <20260904122646.32558-1-hemanth.selam@gmail.com>
References: <20260904122646.32558-1-hemanth.selam@gmail.com>
Subject: Re: (subset) [PATCH] backlight: fix typos in comments
Message-Id: <178957480517.1764874.11280971679880634341.b4-ty@b4>
Date: Wed, 16 Sep 2026 17:06:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Fri, 04 Sep 2026 17:56:44 +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.

Applied, thanks!

[1/1] backlight: fix typos in comments
      commit: 5e1631df673f3d5355acd06263a884e00d8d007b

--
Lee Jones [李琼斯]

