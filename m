Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D78CA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0360B10E1A4;
	Fri,  9 Oct 2026 16:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IIJC+7aQ";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BABD10E1A4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 16:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791564947; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ATtpEt/9bvUEwNBBWYAGhHf1tJroYf15Wq484WiW6zkg71Tqw4Cr7IGoMlS2TL2gXQgjBDCuXfniAzVPsO1pJxctMHkev73+dNYO2JVsSJVil0by6Pg3mqfz+Sg3omQmbsXNWlrMHSLVGFBnU+uUQNed2LNxmuK3hcKHqwbeB5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791564947;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=KkpgfwgLLBE+9I3+HukgzZ7vjApfjh4uaESmMB/uPNzZjeaINk45i/X7dOXJjWCoYFdGEpTulk3ahr+q9FHRR0Sd72wQzp8yhL86AkSHInBKn1CZ+/qXXK7KvnxGBmU2mL1IeuB844Ulkly4KKvsQnPtISNoqQabpaANW1yJpEA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791564947; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 b=IIJC+7aQdqVK/P4OOnTiOfIEvv5/6WhcPARXJUbpxjs3HFRTT92PJB/gw1+ddUGp
 OjS7i0g3hr2GXAmYwqspN4Iot3wTBUjcr3u5Ft8I3QOExO0nXxIQ+Cmgp72SRZkdWop
 /oY7ksAgplTLB4r9b7Vs2ZzS6gTmfNffnCrnn/vA=
Received: by smtp.zohomail.com with SMTPS id 1791564945621243.20648823200918; 
 Fri, 9 Oct 2026 09:55:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 1/7] rust: drm: rename Ioctl device context to Userspace
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260814230923.1292966-2-dakr@kernel.org>
Date: Fri, 9 Oct 2026 13:55:27 -0300
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
Message-Id: <8CB5BDA6-0329-491B-80EE-FCEBA390CB2F@collabora.com>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-2-dakr@kernel.org>
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
