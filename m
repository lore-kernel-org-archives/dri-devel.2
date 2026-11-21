Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCF606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=om3wJcOh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B4F10E234;
	Sat, 21 Nov 2026 07:25:20 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289BF10E234;
 Sat, 21 Nov 2026 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=geRRm6+nqiwHvHqpQ8MJCSugM9I4R96/Wkrdv0T66fs=; b=o
 m3wJcOh0OJ7Q4htwvaaFUEdt6Pn8QjCffi98gR1MRMeGw6NUa1RDFEYBGC7HZdm5
 GPU71yjtiIIJCpn094SF5M/JYUoScVgdtXSPgJEX6p9mpv1avc+g0NREi68clypa
 e2Txk8Na+mnLpgQtAKkikgjsvQO18RrjxbWC75GjIE=
Date: Sat, 21 Nov 2026 15:24:38 +0800 (CST)
From: "Haoxiang Li" <haoxiang_li2024@163.com>
To: "Andi Shyti" <andi.shyti@kernel.org>
Cc: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/vma: Fix a memory leak in i915_vma_pin_ww()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <awAYXcgE4RMg3Hqi@zenone.zhora.eu>
References: <20261118153205.2432736-1-haoxiang_li2024@163.com>
 <awAYXcgE4RMg3Hqi@zenone.zhora.eu>
X-NTES-SC: AL_Qu2SB/6fukAs7iKRY+kfmUwSj+s8WsO0vf4i245fO5B+jDjp1T4OT1F4NHjp+uW9ICG1iDO4agVRzeJlcaxVXYswds6f9bj1OPmK5UeZDBaO1g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <773b434.18cd.1a1fcfe2c1f.Coremail.haoxiang_li2024@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bygvCgD3j4s3RwFrPglzAA--.93W
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hf5aGsBRzcGRgAA3y
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGksIEFuZGkKCkF0IDIwMjYtMTEtMjAgMTc6NTk6MTIsICJBbmRpIFNoeXRpIiA8YW5kaS5zaHl0
aUBrZXJuZWwub3JnPiB3cm90ZToKPgo+SXQgd291bGQgYWxzbyBiZSBpbnRlcmVzdGluZyB0byBl
eHBsYWluIGhvdyB0aGlzIG92ZXJzaWdodAo+KGJlY2F1c2UgdGhhdCdzIHdoYXQgaXQgaXMpIGhh
cHBlbmVkIGluIHRoZSBmaXJzdCBwbGFjZS4KPgoKSSB0aGluayB0aGUgdGhlIG1lcmdlIGNvbW1p
dCBhZGRlZCB0aGUgY2hlY2sgZm9yIGk5MTVfZ2VtX29iamVjdF9nZXRfbW92aW5nX2ZlbmNlKCkK
YnV0IHVzZWQgd3JvbmcgZ290byBsYWJlbC4gSSBhbSBub3Qgc3VyZSB3aHkgdGhpcyBoYXBwZW5l
ZCBidXQgaSBmb3VuZCB0aGlzIGlzIG5vdCBpc29sYXRlZAppbiB0aGUga2VybmVsLCBsaWtlIGFk
ZGluZyBhIG5ldyBmdW5jdGlvbiBjYWxsIHdpdGhvdXQgY29ycmVzcG9uZGluZyBlcnJvciBoYW5k
bGluZyBwYXRoLgoKUmVnYXJkcywKSGFveGlhbmcgTGk=
