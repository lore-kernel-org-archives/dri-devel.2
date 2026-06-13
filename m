Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1F8CD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C017610E0E7;
	Sun, 14 Jun 2026 15:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZKcJq0G";
	dkim-atps=neutral
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1358510EBC5
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 02:04:02 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id
 41be03b00d2f7-c8587427468so644025a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781316241; x=1781921041; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qvlrbvjYmzCXoLrV2hsJdEbJOUWSCE5NGHj2A3xomvU=;
 b=OZKcJq0GV0anTLex0koNheXBXj4gbQMrMTsmxFQo3VoL7NHGPxhIKxYy7vFGKVbayc
 GuZrv1jdWd9/5m0YQxpYkMLVzLo2up/Ou1ppAS1jHjmV1nroDGqkG+y7O96HUlevBh6c
 5tsGWKLyXjkZd3sWXnUPsKTPNBi23aLHJ2+zZ9q4UTJVYWCoSmQHOmb4IpeXpvlXTC0P
 8FU2yZ+NQHaSbnWiejU5e4U16MrONeWxAwd/wMVPTwvAXraUFge+ztXKgIMLgBaQhWVi
 SNXYodCLufCivxoQsKgAFW1Crmx33RgmzKe4oElvyF3QLGetynIGlc0iuqcgaF5nPoUO
 yswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781316241; x=1781921041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qvlrbvjYmzCXoLrV2hsJdEbJOUWSCE5NGHj2A3xomvU=;
 b=PJDk4g9SUMsaIxUUNdEwei4y0xBG04DPHdKPRy8SxUY03uuCSn8nsvijCF0BENAzgW
 o1IFsXNYm8xiSgfBcDX+CLNI/kUn/gLoWkiI/kaMnwpP3E8WsFmsQYhtgP581Ke0G5J6
 u5QApFA7KCteKzusNkqYPtydvi/BG77QI9tLRODD3NJoO2PPmgPYP+ObKaN8qg4YYV5x
 gEphhqXc4XTOQeu7ikXWq2me/TQWxo0Ef4GrQ2UvBRFLeaf1qIQYg9aahjqdJLHxD+zI
 V27eZ8KOwaJfDzu6Ea/fStiEqADg5wqDc1ITCNpVzyV0civRnqF1v+qFKM8PS5lT7R+g
 V+Gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ89TtvPplsVdFogII7XmSqqTr0dttQ6uoP3anFscju93XEXfYgBCID3+kWxtbmfLFlwbjBtxZjXSg8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFnK6a+xj9wSXd3U3uX6tAURXi42KBYfugI3jApBzypVoJOf/A
 Uz9NC0RiNOEM0z6M21HB3V4NZYVazmBhPLmdIAuEvumXI0F/1+tucUvZ
X-Gm-Gg: Acq92OHsSiuoERv1oRI9goOho+GTqlpH3zY6Ao2Il3iQbyxNRUXGovg33+SL0rZOmuI
 AHybSjyYUPSz/T0u+tAaML0sW6u5ZUdSY8ICSYkOyvIiNMxqNdE0+dwjgsDF14vmvGFWzf9zFz6
 Kbud13YBG/eXOYtpT0qh9whS3biOzQFckMYpZ8Z6L+X/nuCMpKYMq48aQsaPwEOg1tGssOVZqkt
 wFCQCD9DphwcuBcZZpBZefsaX0HE1c8K5Y4hyRlxT6kMDGfdfb+8Z0kaxpAqbPpHgh0tjZMMPEg
 l0/bNRR9AUI6BBkOMjEmIqDDyBKuyZyafaxM9KSyGtk/wqe0Lmx+uc7GOqxcyzkmcZOU7zOVYWs
 JEZ/xmimuo/lqoXzEA3AozYFmfxHa7xgTPRC317RuNoKN+L20t7AqX7cpMLTwc9LpL0KvqbhXF+
 mJaVhuQOflKhktJb84
X-Received: by 2002:a05:6a20:2d14:b0:3b4:6265:3786 with SMTP id
 adf61e73a8af0-3b784026fc9mr6690558637.43.1781316241406; 
 Fri, 12 Jun 2026 19:04:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8665186d98sm3006091a12.16.2026.06.12.19.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 19:04:00 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:03:50 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, 
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, 
 skhawaja@google.com, dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 4/4] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <aiy6fWaIILSj6dpr@devvm7509.cco0.facebook.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
 <20260612-tcpdm-large-niovs-v3-4-a3b693e76fcb@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-tcpdm-large-niovs-v3-4-a3b693e76fcb@meta.com>
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

On 06/12, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add a new devmem test case for binding the dmabuf with rx-buf-size=16K.
> The test sweeps RX payload sizes straddling the niov boundary to cover
> the sub-niov, exact-niov, and multi-niov RX paths.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
