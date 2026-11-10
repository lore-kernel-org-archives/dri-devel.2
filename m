Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EC606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1cgX7Ni
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C16EC10E172;
	Tue, 10 Nov 2026 17:04:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 211F410E172
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:04:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 983A4401F0;
 Tue, 10 Nov 2026 17:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C4E1F0089F;
 Tue, 10 Nov 2026 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794330248;
 bh=Gq0M0cu2Lo2dpH/31tGMSg+0YblrzrHJ9B+jvPcEV1o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G1cgX7NiXhXz1FiR4I3hiMIl8Zg3MlXjsdc+UHxBoZ71sJhJIeejhkHzBEscFHpyO
 ehXeoroAKlW9RB8Utvb0oBHHg2hzsHAfyeyVaqKEmnfTPmHMHRZD/yRcg1JToi9PnI
 Usds/guZ1hvt6T7e7+LeCxWlfnMFCQtCj/iYy2CUwcI+f3EovAcj1CG2UzgThf2hUB
 68e+msgJJMgWlmk/1q2VsYMk7RuIEE8R4pA1OBmg0bprVRM3YqNZ4kRKHjto6nBwXt
 jbRyD0WTFLWru0NVnW6DKCgJwtUDRcEGjIf8dcgg/MaEWx11DbfdfUHVEBtgGWJCxe
 u/h8Pe+zuP63w==
Date: Tue, 10 Nov 2026 18:04:03 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>, 
 Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <20261110-spekulant-erledigen-allumfassend-280fdca625e2@brauner>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
 <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
 <sp6gvawt6petvrlky7g6pqaqsp3jwouu6ixarevis5m5vd7fwe@xjxeakzi3nn3>
 <803191ed-6597-4b8d-af7d-812b1b494fee@arm.com>
 <boyk6gdk2qmgj4fxhbluqbtcbhqkgnyiq36hurhomfib6vrogw@tjgi2oxtbvmd>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <boyk6gdk2qmgj4fxhbluqbtcbhqkgnyiq36hurhomfib6vrogw@tjgi2oxtbvmd>
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

On Fri, Nov 06, 2026 at 04:02:00PM +0100, Jan Kara wrote:
> Well, the change is kind of "meh, I don't care much" for me. So I guess if
> you include some conversion that actually makes code simpler, I guess
> Christian might be open to merging this.

No, I agree with you. I think if at all it should go together with a
conversion that actually gets rid of a goto mess, e.g.
mshv_irqfd_assign() or sm.

-- 
