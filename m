Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C2C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498E710E294;
	Thu, 30 Jul 2026 02:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fI6wqLze";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0C110E294
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:05:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 071C3600AA;
 Thu, 30 Jul 2026 02:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6C11F000E9;
 Thu, 30 Jul 2026 02:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785377150;
 bh=7x8AKkOBsrw0bA4La+UA98midhUSUxMgJkViBYIy9cE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=fI6wqLzePBaYQquET0/cMEqOZvPAeABSSJzwlFj0HGdT+QcVeLdEryJGs9kekT0Fe
 83hU0fubc2eJFo1XNhLjMhLHoFqShwPoliRkMVKbmbr0KgMW2FA4D5jwIAtMgBZqos
 v/nqeLT1OfF5H2Hf/lswRDgl8dxviJTQVi1+aCirwv4s59/4JcXjI/hb4EPFH4alty
 8VV+cIbhFBSNTneMDTAA/pWCnriWPfTH/kqeQMv4d29+uBZNhgEyoHp/7avfjfLDsd
 V6NWdZEOtGXKw9WPB+Tm77Jh1wfXJ2we0qkT00NxiRZ8+bvtC13FogcGbklUTkWAl4
 6fwom9wM7rhqg==
Date: Wed, 29 Jul 2026 19:05:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 1/3] net: devmem: allow rx-page-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <20260729190549.4756835c@kernel.org>
In-Reply-To: <20260724-tcpdm-large-niovs-v6-1-7975f62cdfbb@meta.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-1-7975f62cdfbb@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 24 Jul 2026 14:21:15 -0700 Bobby Eshleman wrote:
> +    value: 0  # dummy: codegen needs a number, real value is the PAGE_SIZE macro (header)

yamllint says:

  12:81     error    line too long (89 > 80 characters)  (line-length)
