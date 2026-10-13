Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E91DCC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FD410F57D;
	Tue, 13 Oct 2026 07:53:00 +0000 (UTC)
X-Greylist: delayed 987 seconds by postgrey-1.36 at gabe;
 Tue, 13 Oct 2026 06:54:46 UTC
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC8310F4C1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
 s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date;
 bh=sVVl0YKFWEeW8zool1E3ui30P//TcmWvC+2pSRfUDwg=; b=L3nruNbrflVyJuABlaTnsXyLX+
 Dz/ewcCkhMbEar/DcxvPr0xhZPtDNcPJIS60bes7GHAMx/sLRsfddroTtokalpKeiKgAn8s5Ma9wl
 Fmwh/bfWrWZ3hB3M5f397rqo1QQ79Et5UIJQxkJMX53ah2ALOvnlnGwTgp7W6HVWP0ME=;
Received: from mnencia by spark.kcore.it with local (Exim 4.100.1)
 (envelope-from <mnencia@kcore.it>) id 1xGW9L-00000000Ghm-0Cei;
 Tue, 13 Oct 2026 08:38:11 +0200
Date: Tue, 13 Oct 2026 08:38:11 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: dri-devel@lists.freedesktop.org
Cc: lyude@redhat.com, David.Francis@amd.com, jani.nikula@linux.intel.com,
 xiaolu.xie@intel.com
Subject: Re: [PATCH v2] drm/dp/mst: reject DPCD read/write on ports with ddps=0
Message-ID: <as3R0xAdY92IqaZh@spark.kcore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920022144.2209244-1-xiaolu.xie@intel.com>
References: <016616a21018b45177f134ab001edc6decb4a8ec.camel@redhat.com>
 <20260920022144.2209244-1-xiaolu.xie@intel.com>
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Tested-by: Marco Nenciarini <mnencia@kcore.it>

Tested on a Dell Pro Max 16 (Arrow Lake-P) with Debian 7.2.6 and a Dell
WD19DC dock with two MST sinks, i915 driving the dock over TBT-alt.

Before the patch, every DPMS wake showed REMOTE_DPCD_READ BAD_PARAM
NAKs on the empty downstream port. With the patch there were none
across three DPMS off/on cycles. Both sinks were enumerated and lit
up normally.

The separate black screen after a long DPMS off is not affected by this
patch. It is tracked in drm/i915/kernel#16901.
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEfCO4BD5l0pgKIbbiWJ8D8BulUDgFAmrN0bMACgkQWJ8D8Bul
UDixdw//Vwdq5quU2oGIGXJU1YSMbBKEjxkqaRhBR/QiEsy93lwIlnps2UT8fwh3
EmeyaM+htA1kBzPsD8CZEdUIHDoo7U6lIDEBNeVFAkTjcg77NxIngsZ1ooqsTkcz
OuZGNVzCgmkqk045vcCoqXdqDUn+KFC68WtiSvOUtgGkeFtnsew2LPN3Vz2NA+xi
QzhKJv+QtpJJYgMQUfMZeRKR48IO9wlKYD3zSQW7g94Sh61Y+quVYaGaz7j5pIGo
PQ/AZPCa2iATbBnl29KaTOClMvRAEZ+lXhoZ6FpbBsZflO5Rqf8EH+lyR6J3rbgu
xVJ+Zm+xvEYnYVtAnVtr8uTHY23qQV4i/iYK/E0/CbeJUzELynF5Svz6WQL/Oqyc
F1fjmNrLBklmeeCZnlAveV+AX9OKq+1xzGizeKexu88x3jJAihfMbojdgejl6rke
P+0KB1w1CKAFHXmB9/dg1cfy1YJ9j0daMv64uCv7DlioWHFz2qMVX2A+6MRqwzDR
vGCfJwds+f6opnpvODW/SizUd0bMS1FKqY26gCX8Bmr4DaIGUYjzOqq1H1EHbNtp
S0ul/bqDaIPZPzP3oyRDz/XxLzWn2iGgMiBIRT5fQg5K+6H0/1AQ53PaCmm3809X
mU60tVwTqbNeHetSdMARfrr8rudhjksChNxQQEeMAlmWFpXaUQ0=
=Mkwe
-----END PGP SIGNATURE-----
