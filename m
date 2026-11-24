Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C090606A332
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Keb5HmzB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDA010E071;
	Tue, 24 Nov 2026 23:53:51 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7A010E071
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795564422; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XoqD0lHOEchjqKzEDHzOpqLpX6v36JgdCQLIP/EJHU6RHXClPp/SqO2CALuGKwP6GfGvD6H433L8rphlReZ6iTd4/3MdAeKafqxt0Ekeo4wL1nJ6dGhbm2aSutnzyz9P4qYVPOuA7tKjO119GZsYVRjlu2j46obq0Oqb+/JpDRk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795564422;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wR5WRKpYHg7/bJgHrlSv7iZ44B2Icz8tN7YoF+ud7WE=; 
 b=d9zwYSnJfm+j49xaGiaaYOAAkipJe+0mf0TPCb5UgR7yzsi2w5L8ipMYicjUgytb7bDnICThuMycTmTyhhO16Fo3mIc4xO2LicWQ01d+u6RPePWAbSr6e1ggymWEIIz5PQy8iRT0IdRMU5qUk50BUulxH7nuSD3JLYClR6o1srs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Keb5HmzBziDevTOknAyDaRpmDOgDdzqMNOsO99IxUI1nklnxsyy30RbJD9YZxzgpdfQDyt9RqWrxunARRx/RGnZzL6EyLk2Or7/C3dktf7r+w9OQpuup1Bnj/O8S3EGkLLb1E6GNbMCKLOml3/VDQS8NKKnoxLGnCLmHm7egKmo=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=wR5WRKpYHg7/bJgHrlSv7iZ44B2Icz8tN7YoF+ud7WE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795564420986974.8470354881623;
 Tue, 24 Nov 2026 15:53:40 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v2 00/10] rust: Add drm::JobQueue
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261124122951.878199-2-phasta@kernel.org>
Date: Tue, 24 Nov 2026 20:53:22 -0300
Cc: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <06751FAF-9674-4332-89B8-AC6A32A24023@collabora.com>
References: <20261124122951.878199-2-phasta@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The synchronize_rcu() issue is gone.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
