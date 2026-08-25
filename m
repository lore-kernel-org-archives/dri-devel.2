Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38040C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9219B10E976;
	Tue, 25 Aug 2026 08:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="NmLwgL0m";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586C810E976
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1787647384; x=1787906584;
 bh=HOvGvpBL6vKX/Gy/8vu8P6+iSfQ3ZvawAvrRVtwgKpE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NmLwgL0mYtc0/WRKBglhDItbnKtDRKlAEAJ0O94GaedDAPKTHqbSg533Totd84AJ/
 kpk4mFRwAoaIuqR4jDLN988LHcUlp6RJei4uSz3q9kC+rP0Rv/uowOautYKJS5q7Qn
 nDxxygqeTNeMM39xW3Gd/gjdegZ+5vH6kc3o4YYvCp7bsHJPTLFDhgoEEa8Eip5xCp
 mfHVVVx7fooxIbb6jxKd0udGAAs7CyiwWnREosQQ//gQocwBF2l56dr2ek+CjEVWEV
 nBexEYJ/CLdmgK8NWMeoSmm+7LT49DL/B9O2nqtePXujuuhfUVJ5VI9OfLeU2rtRKF
 kvsSpBTRR8ZNw==
X-Pm-Submission-Id: 4hThBH0Lrsz1DDXG
From: Esben Haabendal <esben@geanix.com>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: <dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>,  "LKML"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
In-Reply-To: <ee366627-a286-46b8-b343-7f88064a25de@web.de> (Markus Elfring's
 message of "Wed, 19 Aug 2026 13:57:39 +0200")
References: <20260810-ti-sn65dsi83-fixes-v4-3-ae9c95c8d162@geanix.com>
 <huX-KL5X5hbADDAlY_Y7yetpfIUeuL1vJ_SZtUhasR8lpLs_KDmmoZ-AkbNOVjguhsSV2OmyrlT-j2dZj0UrUA==@protonmail.internalid>
 <ee366627-a286-46b8-b343-7f88064a25de@web.de>
Date: Tue, 25 Aug 2026 10:43:02 +0200
Message-ID: <87wlteoajt.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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

"Markus Elfring" <Markus.Elfring@web.de> writes:

>> This adds support for =E2=80=A6
>
>   Add support for?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.2#n94

Thanks, changed for v5.

/Esben
