Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E37C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 23:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C740310E08D;
	Thu, 13 Aug 2026 23:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MbzqtOJA";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FEC10E08D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 23:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786663540; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n924rh9G98KwzaxcmihjUEm5ctJ2uJH8ndv8UV9LBOvlBLQZ95uVm6kJpVWGKZISUELecHt5D8vMuMdI9ElMC4hMhzNKrtV3XDOepbTGFyX7+8mNE9Zj+xdN8ot8nu6CjI7B6spkvVE9Z/vI5IQg9300+ujjW0Uxe+ZoBw2QXiY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786663540;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bsAB9n9iPVgQL5LczCdPJzrFKhSNH+7LoT6n3lUlk2k=; 
 b=a8HpQSfnfBoBo0SJUDyum7ETgLFhc0mbdFTpTsJrvbRRskFhpeihSrOAdglknN7amfMQKMWGhTixAs4fol62NyET29fFwnUTLNZDbVUUk4/rUslXbcSD1sj5vbiPEVXOePFdbWrLK8W2VYlU03rqGS+EsWcJKXUV43/HfjbTaU0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786663540; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=bsAB9n9iPVgQL5LczCdPJzrFKhSNH+7LoT6n3lUlk2k=;
 b=MbzqtOJA1AqiLU9rMIzJAsZBycVDkKrzjRwarWtTrbjl1TZ43kOffww5xn2JeeUY
 DpQVjjU/CQt9M9EdZ3IRY89JZ01qBETwlH30uAyIj+cUi9VG6p9oPk/yYunF0EvEacw
 gqQQt4x9SbdFBFLPNqr+LLTblk8gev7ir6qMVt9s=
Received: by mx.zohomail.com with SMTPS id 1786663538023257.92994501579153;
 Thu, 13 Aug 2026 16:25:38 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 3/3] drm/tyr: add GPU reset infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260813-tyr-reset-impl-v4-3-b36fcd0805b2@onurozkan.dev>
Date: Thu, 13 Aug 2026 20:25:15 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: 7bit
Message-Id: <D4F91EDE-5FD1-41F8-B5AE-D8C2EA25545D@collabora.com>
References: <20260813-tyr-reset-impl-v4-0-b36fcd0805b2@onurozkan.dev>
 <20260813-tyr-reset-impl-v4-3-b36fcd0805b2@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

Hi Onur,

Can we move the iomem to the HwGate and get rid of its Arc?  This way we
ensure that all hardware access must consider the possibility of an ongoing
reset by having each component that needs hardware access hold an Arc<HwGate>
instead. Perhaps we can even broaden this to "hardware must be powered on" at
some point in the future.

Otherwise, this looks good to me. Let's wait for Alice too.
