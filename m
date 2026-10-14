Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81989CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E9311216F;
	Thu, 15 Oct 2026 07:56:56 +0000 (UTC)
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DF110FCA7
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
 s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date;
 bh=MGpHu0f14Q5TwLfq2LBRjQIPaF1PJLbbc1dVWU+dzmA=; b=iNIefWQf7xFRc0zmJwxJ8+qYN6
 6CkXohhpdC+Uy5pikF7FXbT6u4Fhu6gM6rGgCPSTo3FKXh7spNzdGHp3OFGYdhiwhsjQT8P7rDLOl
 QgwL5wfR//J+6Ij6NTOanC2wiK5Ey6XlB0PN2Elfttar3JZP5PhM1RRC7YSje5G26b0c=;
Received: from mnencia by spark.kcore.it with local (Exim 4.100.1)
 (envelope-from <mnencia@kcore.it>) id 1xGvhf-00000000Jhp-0Hdn;
 Wed, 14 Oct 2026 11:55:19 +0200
Date: Wed, 14 Oct 2026 11:55:19 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 imre.deak@intel.com, jani.nikula@linux.intel.com, lyude@redhat.com,
 xiaolu.xie@intel.com
Subject: Re: [PATCH] drm/i915/dp: clear and restore MSTM_CTRL around MST DPMS
 off/on
Message-ID: <as9Rh1Yt8Fkj6JpE@spark.kcore.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014081448.2320363-1-xiaolu.xie@intel.com>
References: <20261014081448.2320363-1-xiaolu.xie@intel.com>
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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
WD19DC dock (Synaptics VMM5331 MST hub, fw 05.07.08) with two monitors
behind it, i915 driving the dock over TBT-alt.

Without the patch, a DPMS off of more than about 6 s leaves both
monitors black on wake: the link status of the sink behind the hub goes
from 0x77 to 0x00 and the hub does not retrain it. With the patch,
30 s, 60 s and 120 s DPMS off all kept the link and both monitors came
back. The log shows MSTM_CTRL cleared before D3 and restored after D0,
before POWER_UP_PHY, as intended. Details are in
drm/i915/kernel#16901.
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEfCO4BD5l0pgKIbbiWJ8D8BulUDgFAmrPUYUACgkQWJ8D8Bul
UDimag/+L0A6aKYws/asUDWsKnx4DjKXbQtXjYCVXx8Sqv7wG7PgYvXOONOJzvD1
dxUOxuWLDBx6sRBA6zLmtIdkkifPUHbWhADQLIOnmNqIGutzjg/Rg/TIqmtufy+w
J4lxsmO6khoLa16dZZMp9p4CYgQMOd36NuWG/uSBNcNF96uxzZYjCoO5uXorCkg/
7SCa2neKrIoXXwSEuamQC3FB83I0PXoaxP/FgzZmYDzN1IEUya4EkS78jIPCGmWC
54gz9+hNz0yRT7IgfoluNzHVnP8GftLS7t2DPH1ClZVxw6bE+UnBwpJRQ9mpCkXd
DX3RCZq9E176ESqIDKI/4d+nO8AKQp06aiOExDylNU38NlSNOpPH8iN4XqwYZ2hv
WlpR33hPneA1zosdZ6oFOAPNDLvF1FFuUFtA+wVLJLNNoNTRAVseHGZsR/xdL7kh
X0gIyu1h2SP4wfKySiuvUmgQVm0uFphr4x+FgKn1XoZ+P0CDyjxqoFVDvE8iplb4
1IixcQAPvFasF7wq3pd2eAUh7n2zMcroi99cllGY2uPbxiOPhiWzcVV1NmQ7nHhq
uFcyTlM8nV+TdZYYGCRLFkH7MHskzEGbKO+CQkYrayRPcZxZwnytnHY+CyqGr4sY
732Djo9oELBZF/fYhSBiVi7cij0NFDdadvhV1gfThIT7BH+5qhs=
=2SVO
-----END PGP SIGNATURE-----
