Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256E4C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E23010EBF4;
	Mon, 14 Sep 2026 08:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UalSTNJM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A96210EBFA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:12:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FC28601DB;
 Mon, 14 Sep 2026 08:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561F41F000FF;
 Mon, 14 Sep 2026 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789373569;
 bh=J1egWE5BO4oLYUePaDen4dsUucrzJfqbER4QMPWsIGk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=UalSTNJMErzVSncsQ1mPbwAjMwKJOTKwo687Hn/7h32CLMFODz+IqIZ/K9awHzuqz
 me1ciA8zcBoYCKCBU8rLeBCUGJ0WOqn71TXiqmTVGuRHEpqKrIaQiKwMBwNOImCfvf
 Tb/QNpZPGBuLd5eW65IYMVqm3ApdVhjTMjgvpzuTRjKsoBRttQfZBM+QGKu1vJ3fw5
 QxsMR8nvquou9wNb7+T8pN0lNoja7TovdseYVySiOsMkdZGjdD7w+fDgTq8EJ/9APf
 i1wbBhs4EOkZDz8+EBpXxO8bFDOcmVQl7H61yWegdqRCMQlREvslNAka/1WF2wEkLm
 Iq8MJbPPpozsg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 quic_chennak@quicinc.com
In-Reply-To: <20260907070356.509-1-jianping.li@oss.qualcomm.com>
References: <20260907070356.509-1-jianping.li@oss.qualcomm.com>
Subject: Re: [PATCH v2] misc: fastrpc: Reduce console noise from expected
 DSP info, reserved memory and session messages
Message-Id: <178937356713.258680.1119640361942817879.b4-ty@kernel.org>
Date: Mon, 14 Sep 2026 09:12:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Mon, 07 Sep 2026 15:03:56 +0800, Jianping Li wrote:
> On some platforms the DSP firmware does not support the fastrpc
> capability/attribute query. The DSP side returns an error (err: -1)
> while handling the request, so fastrpc_get_info_from_dsp() does not
> return DSP_UNSUPPORTED_API but a generic error, and the "else if (err)"
> branch in fastrpc_get_info_from_kernel() is taken.
> 
> cctx->valid_attributes is therefore never set and every open()/query
> re-prints the same "dsp information is incorrect" line. This is not
> tied to boot timing: it can be reproduced at any time by manually
> starting adsprpcd. On RC builds with metadata flashing enabled several
> clients come up and flood the console.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: Reduce console noise from expected DSP info, reserved memory and session messages
      commit: 94778611d71b57ff917de507229e1c58ad9deba7

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

