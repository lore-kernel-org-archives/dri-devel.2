Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD616C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AC910E08A;
	Wed, 26 Aug 2026 14:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ALrcouVf";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FFB710E08A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787753161; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B2fi+Xa182dFXeCL1l7EKIx8ojZfN6k/hsq5NrN5JKcE6djMXGHMVfLNtu0qvR3cHH+taNBOoFHwwzjXCxQ7klyFYOWz8BLoy4k/b12KZNnG/hzY9DUsJnkPommXuVsj51NFjLy3MYE8FEtZAJU2i4saAvVD5KKlD2BN1a28x2g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787753161;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lcsqwwXhWVmoSbPbE7DPyh9awywoWMTp35RFoFX1es0=; 
 b=mhUfz2ezI5sNwXlxo+/AYr58YZQHEgv+TGohOl09iF2i7NvsN405H6ESn533GFQhQzm8fzsBxaUr+J7mbm3wTswE1+Tpsl3v36VUAntWOos1V3YyqKMRGAiMcdzsyAFXj5QyCxMu5lFHqsYKgEdS4VX2cjYI4PeDvFWLneXUCQE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787753161; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=lcsqwwXhWVmoSbPbE7DPyh9awywoWMTp35RFoFX1es0=;
 b=ALrcouVfprpB4OgpWdWQIbBm+ZVKR4WrMeaZTaE2o1dvrXt6tKjgMBsJaV81iM4k
 /FnpsVW46+xiuY/FbP3dMOQ/Gx8mV9WqR1FK6OTbTDZXyu66Fa7sFDmyXJXr8cZyCvw
 koOeA401LAjzNvzgn2H2sB9YZFl6wLdbzQmsoXdQ=
Received: by mx.zohomail.com with SMTPS id 1787753158261687.4971270678526;
 Wed, 26 Aug 2026 07:05:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] drm/tyr: unplug the GPU when reset fails
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
Date: Wed, 26 Aug 2026 11:05:39 -0300
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dakr@kernel.org, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu
Content-Transfer-Encoding: quoted-printable
Message-Id: <62D24E3D-0956-402E-8451-24FADC8D357D@collabora.com>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
 <20260823-tyr-gpu-unplug-b4-v1-2-e99c07d4c785@onurozkan.dev>
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

I have nothing against this patch, but as with anything touching =
Revocable, I'd
rather get Danilo's opinion here regarding revoke() and the Arc in the =
registration.

Otherwise LGTM.

-- Daniel=
