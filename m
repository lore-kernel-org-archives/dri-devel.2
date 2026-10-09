Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D09CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4F810E1B5;
	Fri,  9 Oct 2026 17:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VNw7noiM";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E912810E1B5
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791567751; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B/wtDLc7L9wDD4bAL2wM1fhRSNITgDWzB16hHkuf/L+1xcDkI2Mb/McoV54LhimZYQV1GbSq5WaysHsggz2c/gDyqjmieZILyTxdSPfmDg9EtdgJmQUrUjJw+l4A3PXsMSCvyjGDtI3G0PBn8crHOBrvN3qCikatUv8nIty4kl0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791567751;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=Bi1Y0RGUX74/diesBFY3NeLWlftGJYPS5OSVFvJoP2wxUmVS/a4RT2veWQSQQgWqAUsXU1i+CEaErAJmCCUQp8dR0XjumUbydnMSK5JBalvObyLnIVu5iWEJCPpdB7BDqsdGIAD/T2sk4mvA4f5sCBNsC78NA8T5MnJET0pkCMM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791567751; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 b=VNw7noiMU90uF1OjPtYydX4WQk1Z0oXG8slcjFc7SIw+AUKxNiDLYVmgU5Gc7T+p
 z18XYHB83QoXPhAViW29HG0lEgMQFqDpzTcDzL2/Xfd2vHCV5GOLElBOdddZApsDZM5
 XLLQQLNZzBld2Kb9MH39Hi/Suv1zeP+K0ufhSuC4=
Received: by smtp.zohomail.com with SMTPS id 1791567749830396.08748854537646; 
 Fri, 9 Oct 2026 10:42:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 3/7] rust: drm: move file_operations from gem to device
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260814230923.1292966-4-dakr@kernel.org>
Date: Fri, 9 Oct 2026 14:42:11 -0300
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
Message-Id: <E225E644-0C7E-4D17-B221-88C31577EDDC@collabora.com>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-4-dakr@kernel.org>
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
