Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1217C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0638D10F09D;
	Thu, 30 Jul 2026 21:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NUrFCp8Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A188010F09D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:02:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB67660052;
 Thu, 30 Jul 2026 21:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095341F00A3A;
 Thu, 30 Jul 2026 21:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785445335;
 bh=QVnUIg3zVxrhmz/jfWoB3DVtcaBShnzGhL0TomisEM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NUrFCp8YA8lyTVf7VxHyeW9X1qvw9ys9UYFv6R6FOE1abGxVAaxV5Y8GaQ5Cn1FNk
 AiL3NlIPmjCgFBTrXQo24rf9eRBRLezLjMgoMGeIAzbgLvxhgdvAwZStonjT3rX+N+
 I6TX4E/QL4P9Y13tNSkRpRNBJJh+erTpnT2SCaUNq5+WbIOJGhZTYZhuWEQug/fshT
 PM5MexRuQIO4oosa6DHZUZJEKayWVETUkg4Xgw92MwbQ0Z3ADhwL5j8HQweI8CskMX
 FSbWgRpIfgw2oljrC8DzoyeD21ChxPsGMZnHsJYBk0+B2HPnYv9w4ZHdNJdmJZKBV0
 vyP/qjjlNGV+Q==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Len Brown <lenb@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/11] rust: driver: use pointers instead of
 indices for ID info
Date: Thu, 30 Jul 2026 23:01:50 +0200
Message-ID: <20260730210149.1117242-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, 29 Jun 2026 13:39:34 +0100, Gary Guo wrote:=0D
> [PATCH v2 00/11] rust: driver: use pointers instead of indices for ID inf=
o=0D
=0D
Applied, thanks!=0D
=0D
  Branch: driver-core-testing=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/11] rust: driver: remove `IdTable::id`=0D
      commit: 3474bbba4ddd=0D
[2/11] rust: driver: simplify `IdArray::new_without_index`=0D
      commit: e49f626ef541=0D
[3/11] rust: pci: use `Option<&IdInfo>` for device ID info=0D
      commit: 4fcbf7f1e4a4=0D
[4/11] rust: usb: use `Option<&IdInfo>` for device ID info=0D
      commit: c7b6e07f83b4=0D
[6/11] rust: driver: centralize device ID handling=0D
      commit: 1d92f2e8b881=0D
[7/11] rust: driver: remove `$module_table_name` from `module_device_table`=
=0D
      commit: 0deeb4222dd1=0D
=0D
      [ Consider the serdev code merged in the meantime. - Danilo ]=0D
=0D
[8/11] rust: driver: store pointers in `DeviceId`=0D
      commit: 0b76335e8f32=0D
[9/11] rust: driver: remove open-coded matching logic=0D
      commit: 2c5d17cdc4e9=0D
=0D
      [ Consider the serdev code merged in the meantime. - Danilo ]=0D
=0D
[10/11] rust: driver: remove duplicate ID table=0D
      commit: 17fcdecb14b4=0D
=0D
The patches will appear in the next linux-next integration (typically withi=
n 24=0D
hours on weekdays).=0D
=0D
The patches are in the driver-core-testing branch and will be promoted to=0D
driver-core-next after validation.=0D
