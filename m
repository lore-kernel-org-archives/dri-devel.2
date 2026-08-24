Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037FBC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3BD10E09E;
	Mon, 24 Aug 2026 08:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="hz+dYR6Y";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E5810E09E
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787560871; x=1788165671; i=markus.elfring@web.de;
 bh=P/+oVr8qECeIqMhQeDC8U2rN4n2CNCgHp5h+R0Cn4So=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hz+dYR6Yq/Th7A54TItWZn6L5Hxs5qcVGFN21ZWmG5IKsIaUNO8HOsEfs2aXPNvc
 IrDiBQ4TuJyCXv8ymwmvVJZoUo5eaETZkDHji/CK6imUMZ/WAt+hzMGn4R5xu08w3
 m3CQeOxIyY4/11MQqE3aR6lf8B/8c4f1kbQu+2xpC2keWUmUm48xPId7I676qf46D
 lk+XVtJjM7Lw0G/RjThhh/qSfF3eTomRqZrbuvgWy2LB3KErvdDsy4D56YVpjiGX0
 lLLHBPslTINmGhBSrYBBbpduinjAteubIpseYkiP8ZRwxqdbQn3jg6fISqAKkr3Hf
 UnN1R4EDz2wvG0zHjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Epo-1wuHQ704iu-00xocU; Mon, 24
 Aug 2026 10:41:11 +0200
Message-ID: <81a83138-b6ad-46f0-b510-951e52f3294c@web.de>
Date: Mon, 24 Aug 2026 10:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Manush Prajwal <manushprajwal555@gmail.com>,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Paul Kocialkowski <paulk@sys-base.io>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260813111037.724-1-manushprajwal555@gmail.com>
Subject: Re: [PATCH] drm: logicvc: fix device_node refcount leak in
 logicvc_layers_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260813111037.724-1-manushprajwal555@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:y4nS9y5J1xQcx+XS4xUYiajCIVNS4Fugf1y5nl4BtIwLe1rAT7w
 7dKYPX8EFrpkn7PeL/sIZBBfGE5Ls0QeRpHBYB5cKr2rcx+Nr0+8b80ikq6w8aa7rIos0Or
 j8Y2gdqE37WWj0UM6F77R15b+zHuf69AwO+GzS2AZRVm3DO1p992nxtyZdBCOUz49Sn5jlo
 pJdfvrIspyTtOoghRgd7w==
UI-OutboundReport: notjunk:1;M01:P0:gLZ6xFm4wfw=;NcLYdGRWuSKPeLs5QloVoTGpNH8
 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
 B7FfPO+w==
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

> On logicvc_layer_init() failure, logicvc_layers_init() releases the
> parent layers_node reference before jumping to the error path, but
> never releases layer_node, the child node held by the current
> for_each_child_of_node() iteration. Add the missing of_node_put()
> for layer_node alongside the existing one for layers_node.

How do you think about to increase the application of scope-based resource management?

Regards,
Markus
