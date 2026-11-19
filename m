Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110F60A2612
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX/NEp2c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7CD10E672;
	Thu, 19 Nov 2026 10:34:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D76510E672
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:34:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8655760D44;
 Thu, 19 Nov 2026 10:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098071F000C4;
 Thu, 19 Nov 2026 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795084471;
 bh=r/LV8uKUhAkdDubPBIfVQFAg/c0ZWstIuqiCpM+nQM4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=PX/NEp2cjUqb/XyjeDzNWgCDHNUkJOZbWfDYM4GDACsgh0+d3hjHj6nE+o9K3ZCGK
 oHCTdQlKmyThYmL9KLb5B5f+83sTmD4DkQnf7UrXCXblAkPWzMAjXHOc0+YP0CzfIJ
 z7EjTUkNBVSbhFCivyam3Yl97jq3hMuoFSbx+MuRNtn2z1WM4dMHWWnm1bvx+1wmfX
 XluXsNnTNRLdogYO27QLHi3b7Q7NTtrI51ltA8iYc45coE6HTNeck5Qg0UzBZ7OZ84
 OTurByS112rxqk1If8Nv6T0bYhA+5wyni7/jILoaehSA1NN/PKg57LfTS+h4LzKPud
 Tneh/ZGH8g9Gw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 11:34:26 +0100
Message-Id: <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
In-Reply-To: <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 3:08 AM CET, Gary Guo wrote:
> On Wed Nov 18, 2026 at 11:37 PM GMT, Danilo Krummrich wrote:
>> The firmware, buffer, VM and MMU types use 'drm for their resource
>> lifetimes, even though each parameter is local to its type.
>
> This doesn't make any sense, a lifetime on a type by definition cannot re=
fer to
> a scope of itself.
>
> `'sec` is not the lifetime of `Section` and `'fw` is not the lifetime of
> `Firmware` and I think this is just confusing.

Yes, this was badly phrased. What is actually meant is that e.g. 'fw constr=
ains
how long a Firmware instance can be used.

(In the following patch, in TyrDrmRegistrationData, Firmware borrows Mmu. T=
hat
borrow has its own lifetime, distinct from TyrDrmRegistrationData's 'drm
parameter.)
