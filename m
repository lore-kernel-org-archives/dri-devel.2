Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E425C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 08:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58AD510E3E5;
	Wed, 12 Aug 2026 08:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R08XvcJe";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834C210E3E5
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:34:38 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4765eec32e1so13622f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 01:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786523677; x=1787128477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RQFDNJdHLgyl4OSlrYmzm/QJoU+a+hgO0ne2eZ9DCag=;
 b=R08XvcJeC6zul6qAKGFWD8loqJAcuJw8Rj5u0///d89btUzqw2VpqGHY4D9+dpLnAt
 b4KB8jiBljewB80ypgbo5Hasu3IHS0PMwvPuAPDkLWzX8SRkSLb4hEdUKbEhxX0do085
 J26TZPz2qHTuai4LJ+YNOkWGmtpIW2tUbB7DfsJwe6XbmlrwTLzG/qv7SdcNezbyU54N
 kCDLh69YA2vfkNF2TWy2N6A1Hn8fYirR+AwbTVS66txKwNPcc6cIt0mI+wsl1Q7vbDWm
 0YPRqimZX5G77ZaYsCiBPNN7peyahhLxziqe/Cj0zrdP1Xy+t+eoC37zA1lbf1WxAC1k
 IthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786523677; x=1787128477;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RQFDNJdHLgyl4OSlrYmzm/QJoU+a+hgO0ne2eZ9DCag=;
 b=VFtNmk6b1GD0PVVVi+U7Zmw0gYygmXrsKz3ejzkQ3LgZPL94eoxcQv64roYftMS+re
 k98fzcGGhuojMEmPtQHLvUeWur/5w+LbUTjTJQFl2WI5YNUzfUzW7GcFFXmf5FSQD+2q
 eVrccy5Sdm2NzpNaXgc2Bj30XDlzh3/RC5Y0fmxwo3YO81KOd6YStuTRzmJ+QTHVcYnC
 B/GU1BJm2KJrDkisJLmUNbqzjpXShsOndeInVgv+2u48vz7MNh4n16DA1pL7pDSvQGyA
 9wmknCxVJwSJ3itEcvYhN3qMDfq8k4dwPmF/1KeIQWFnfwYVoD0yMrW2LfOjS/6QqDew
 Qeng==
X-Forwarded-Encrypted: i=1;
 AHgh+RrucAzQDVTm9dQtqLzT7KqApT7sKz/OGRzW0jEG5w4Ghe7ee5kJy84+0i8TilvXVp5OJ8hIOTsu4u0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAza4CYxwvTu91r2J8MKoPZByuBm8v1S0lh4tkvUbwU5W93xMR
 AxxuoXBJk9egZYve7+f3AYpfSV00t3W6699JCUn8CC+gzMLbTx8C1/Xh
X-Gm-Gg: AR+sD11KwKwjouaWYLtsrnkfDP7xn/YbckgeHT/bIsOkoX/kOn+BFe+phCoFtmmNDXO
 Caq4AU5d7DUXQ7wRUmr8ILY2niNiPQhal1lUR3QQlxEB0AVEH3dI02ODOaT3kJFaCp8qK0HNDf5
 3B+NXRFdDB+i+MoGVL9kijhL2gFAkFbvjQhm2VfA+ABKYqNlrS/nfmNgZ0M2oC2pui3FlZ+gHBH
 95+5/qtILg+bdGoi+i7IXp2ia8hFAyzVak+ORlZ5ecDHr1OHKI4JoywW0Zig5Kbn7M5XEXJS8Pg
 viicysiaRl8xQKvvIDND/duMXvXjGLhUKREMQ5/JrWISZweh9aACGq+WB59sKpwV3tvcmE8v0WM
 d0e9AoiEyr6zeQVysdfJGwSi8plHXVFft7Irb20MbEQykX4ho8FiFZovUDTQrkIGU8zvcQLtqIO
 rualL+k8aZFK/BdqOAKE7booZ760bjg1YPCacVfb34Y1sTJ8CV65XGv6pIFdnklh1qVk0pXIkLc
 jjjk+pjdwvT4nRir7e5xdKULg9/ttMOwOKoQsLugCMUgQfYe1AKCVUI4DiuThHnd7Q8IQ==
X-Received: by 2002:a05:600c:c8d:b0:495:7561:a9cc with SMTP id
 5b1f17b1804b1-4997c16802amr21652985e9.4.1786523676661; 
 Wed, 12 Aug 2026 01:34:36 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B84A600FEFE3CD53078703A.dsl.pool.telekom.hu.
 [2001:4c4e:1b84:a600:fefe:3cd5:3078:703a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e675sm5679637f8f.23.2026.08.12.01.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 01:34:36 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jiaxing Hu <gahing@gahingwoo.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
Date: Wed, 12 Aug 2026 10:33:56 +0200
Message-ID: <20260812083357.60014-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811212818.10487-1-royalnet026@gmail.com>
References: <20260729130743.128876-1-royalnet026@gmail.com>
 <20260811212818.10487-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A correction to my own message above, before it stands uncorrected in
the archive.

I wrote that the two test reports cover "the two NanoPC-T6 variants
besides my own board". That is wrong, and it misattributes Sidong's
work. Sidong tested on a Radxa ROCK 5B+, not on a NanoPC-T6:

  https://lore.kernel.org/all/20260802131328.75038-1-sidong.yang@furiosa.ai/

Diederik's report is the one covering the two NanoPC-T6 variants. So the
coverage is three boards besides mine, on three different designs:

  Tested-by: Sidong Yang <sidong.yang@furiosa.ai>        # Radxa ROCK 5B+
  Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus

Apologies to Sidong for getting his hardware wrong - his report was the
more thorough of the two, with clk_summary before and after, 90 runtime
PM cycles across the three cores, and bit-exact inference results, and
it deserved to be quoted accurately.

Nothing else in that message changes.

Igor
