Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D77CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDDB10E85F;
	Tue, 13 Oct 2026 14:03:37 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334D410E85F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791900206; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CQNB2CAmqUjisynnHlsJcP04Gn78YOHZu2344N2XhTa+7uiN75OuSJs+gKfCai+Zmu3NmT1e16B7vVyzNhah6yo6p0zljkd+1o/XdBbdZozqyrAzZ2rc0cBsszceTebpoA/Im4ihxw0thPK3xy9vc5yu6txcJXRo2mTHeNfvv3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791900206;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=VUkxYkZql29uMXV96wC3lDhMVHcQGHfNSVV7kAiIK0aom4rWyIY4Xti++qsRdT5lrl89wxsTQrxbiAJlOxhSsGfTXD0p9MpeUhLy6tgNDnXDwnNtDiETrJJuhdxLMh4EntAmP9TMUCXyn+ZcT0enZmBpaYHt44EL2kv6qWgjTFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791900206; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 b=XhbUiytGtQd6opLVHO3bY6MU2u0o+s1gLD+dRLY5JXv/IVCR3JjsMCnnZIWTutZH
 vnVo7pKqdLcvofejbRMzxluvl0TU6nRfzae9rPwMtM2IG/dGe4o2MwTu9qv3hNkx0eg
 aJsXlz21PI2hrl+i5KX83WvdpM3+sfiNl5d1NkC4=
Received: by smtp.zohomail.com with SMTPS id 1791900202871918.3489215289943;
 Tue, 13 Oct 2026 07:03:22 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260814230923.1292966-3-dakr@kernel.org>
Date: Tue, 13 Oct 2026 11:03:00 -0300
Cc: aliceryhl@google.com, acourbot@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, brauner@kernel.org,
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev,
 deborah.brouwer@collabora.com, laura.nao@collabora.com,
 beata.michalska@arm.com, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <22FB0923-C538-4529-90A0-067D790DF863@collabora.com>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-3-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
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

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
