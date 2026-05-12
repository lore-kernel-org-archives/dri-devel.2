Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92BFCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 15:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 344A410EAE6;
	Tue, 12 May 2026 15:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XgbdtI/9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37FE10EAE6;
 Tue, 12 May 2026 15:07:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8007A418A7;
 Tue, 12 May 2026 15:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B40C2BCB0;
 Tue, 12 May 2026 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778598447;
 bh=VGUGdM62zg1gAC6kZ0WEWMjSc3iUQoFTDxC1OOhBMYo=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=XgbdtI/9XlYUoCERPTGPOLo6a2fOk6ophOyBEVrFZxf4WZYquzfUQ7oRQVykX7zKQ
 zQt4BdAbbIh+SnEs7BsgXrUJScqS3HmvlrC4NVpTFylYQlYLSHRN4FhkfhYMbeKbre
 5lxd6ZFQbZcr7fuHZQJ+DSf2Kg2BaDM0eMTIrHJzkndU3DyTm9rzr2gq9pqQxCPwfB
 DnmSNKvPl2gRYUi7kAVBV0s0nqm9K0ljV2AP/jacCdTa8f7z+/AcwZnaS3xWEMAQg/
 nuS/50cBo01Pdg1VWxX8ws3mo6vRVwNy85+X6miuZczfFIi5zF1SEkk6uvdbuFQwRP
 0lxILMQrG2pug==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 17:07:21 +0200
Message-Id: <DIGSJ00KYS92.1FC0JUD8FHRD1@kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 0/7] driver core: remove software node from platform
 devices on device release
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <david@davidgow.net>, "Rae Moar" <raemoar63@gmail.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Maximilian Luz" <luzmaximilian@gmail.com>, "Hans de
 Goede" <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, <brgl@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <platform-driver-x86@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
References: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
In-Reply-To: <20260512-swnode-remove-on-dev-unreg-v5-0-0035eff63812@oss.qualcomm.com>
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

On Tue May 12, 2026 at 1:59 PM CEST, Bartosz Golaszewski wrote:
> The first 5 patches are part of the fix and the remaining two add tests w=
hich
> can't really do harm.

I think we only need patch 1,3,4 as prerequisites to not introduce a regres=
sion
with the fix in patch 5. 2,6,7 can go through -next subsequently?
