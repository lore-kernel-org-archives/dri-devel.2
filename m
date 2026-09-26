Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B47C9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 02:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53C310E046;
	Sat, 26 Sep 2026 02:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="D0kFkN2H";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD11910E046
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 02:45:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790390697; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kZ/avIoaWPHy8OoF9IcRpPcr+dqlSw2hpkLovlengxgzh6le9OGMeNaPvSzkrDeGPYWgt9nA2T2QkpUaykLZ9h6R/IAQTiBYnvI/4EHjySFBoXwHBhw58H+f5KubM3U3rBhoh9g06rzBrZfbaFIthCT873JFjTMaLHwwlOivS8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790390697;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
 b=ffxpmLi12Yk7RVgAyqN214iiqKIKY9v2yXNaCnczWR3/lD32Hd6daCRMQ2H8U8dFOeDoPqahI17StO6igi7t8yk4ZhsoGnASVkyL704tSLNovJyPPRBB1fzlGToiiV5SE3UGQqA7ghq/AtUoH80fmkgbz2hQ5phtKdm2iTVhCac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790390697; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
 b=D0kFkN2H//ZpbVgEHnCU4mb+feyLHQ6FRG3uW0nwLaVtfDOIl/arbKFh8bgM+sIq
 7t/MV57vWJO4PGl6d2jeneUhjTHStucTv2hzcJJ/eql0AkgHLuQmPI3KUZTFYoumI7h
 1OzP4Kex5WweerZcBXqO08Gc4UYpAfj7slNblQ/I=
Received: by smtp.zohomail.com with SMTPS id 1790390696617100.96788790495134; 
 Fri, 25 Sep 2026 19:44:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v3 2/2] drm/tyr: safely write GpuInfo to userspace
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260925-b4-gpu_info_intobytes-v3-2-e19bcb71980d@collabora.com>
Date: Fri, 25 Sep 2026 23:44:39 -0300
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <08520F3C-9FFC-4EB3-9DFE-4FFEBF14B041@collabora.com>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
 <20260925-b4-gpu_info_intobytes-v3-2-e19bcb71980d@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
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
