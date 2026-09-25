Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B88C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 19:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7B310FC08;
	Fri, 25 Sep 2026 19:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lta26CTJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8A510FC08
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 19:10:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B50E60136;
 Fri, 25 Sep 2026 19:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C64E1F000FF;
 Fri, 25 Sep 2026 19:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790363416;
 bh=WIh5MF91TgNDRmG6Qisl3WLz2tFz4iMG+XOqdmL7CGE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lta26CTJTzuqDDh5KI8mVWRhpEM81U1UcckDr7elT2XmDDv9u3Yu83P5Kh49UB1d7
 3RmumOK4R51exJOZZNWGrKtF5MQN87aNO+1fQdjMPzcQisfnSm1Sv3mQpPjr5nVKML
 ClXq0r1H+aVB7Wb5sxjDOFcwtAuh3SeOaFRNklbtdCY2DF5NQOUE8Q4alUJYQJ7BjU
 0WLKQ8Gl14aZLEKpS81xG/puqobi7SQ6pP3/HchhrBK1Sd4KV9rXlWut9JVd7yL2qs
 c3EtSA68/rbFVVNiAjBjoowFqz46o784ouT6Tas+VISMbCw56jRrP+LfDzqv2gbI6h
 4Y8PV2u15/CsQ==
Date: Fri, 25 Sep 2026 12:10:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Konstantin Sinyuk <ksinyuk@kernel.org>,
 <dri-devel@lists.freedesktop.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Francois Dugast
 <francois.dugast@intel.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Ilia Levi <ilia.levi@intel.com>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
Message-ID: <20260925121015.08b8cc15@kernel.org>
In-Reply-To: <ara5iTl7bmgWbPW9@intel.com>
References: <cover.1787552412.git.ksinyuk@kernel.org>
 <20260921131911.532d81f4@kernel.org> <ara5iTl7bmgWbPW9@intel.com>
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

On Fri, 25 Sep 2026 14:12:25 -0400 Rodrigo Vivi wrote:
> I do understand the feeling here :(
> 
> But I do hope that you reconsider your position here. We had such a great
> experience with the drm-ras using the netlink and I was really hoping that
> we could just reproduce the same experience here.
> 
> Netlink is such an incredible API.
> 
> Would it help if I take the maintainership of this drm-fabric netlink
> along with the drm-ras one, ensuring the same consistent and clean usage?

Hard call, I have nothing to complain about with the drm-ras work.
Purely worried about the time :( Well, that, and DRMs general love
of Rust which seems to be about 10x less development efficient for us..

Let's start by feeding this + the spec into your LLM
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/netlink.md
