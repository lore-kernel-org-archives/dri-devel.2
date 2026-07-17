Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4F7C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE4A10E3F6;
	Fri, 17 Jul 2026 11:25:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="RWQpko0Y";
	dkim-atps=neutral
X-Greylist: delayed 353 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 11:25:23 UTC
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF1610E3F6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:25:23 +0000 (UTC)
Received: from fews04-sea.riseup.net (fews04-sea-pn.riseup.net [10.0.1.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4h1nVp0v8kzDqP1;
 Fri, 17 Jul 2026 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
 t=1784287170; bh=0X369mwyOMIFk/r3d3PQY6CeGGMZAcaEUO1xF8171Hs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RWQpko0YA8oIPk3GMWsjjLkGa4P4A1qlvlu80hoW3k9haS9kM27AWCKQISOJLRkeo
 vhG1eCVONDyUkZ6cQifYVaDpwezhlkzXw+j0rnNgPVw4CBxH2jWO2rGVxd9aL15fOk
 Qzm/SdYID3jDMY6wICmBGhWP8EYCwdJ2hdFiFCUQ=
X-Riseup-User-ID: F2AEC4D09809E501C7F2D29DBA705E7DEACF772D6DC14CD920A7E0B6F392FFFA
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews04-sea.riseup.net (Postfix) with ESMTPSA id 4h1nVl146bz5vNQ;
 Fri, 17 Jul 2026 11:19:26 +0000 (UTC)
Message-ID: <9fbd796b-d87f-4ad0-923d-3f8fcd0baa77@riseup.net>
Date: Fri, 17 Jul 2026 08:19:24 -0300
MIME-Version: 1.0
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mailmap=3A_Update_Ma=C3=ADra_Canal=27s_?=
 =?UTF-8?Q?email_address?=
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260717111559.2759217-1-maira.canal@usp.br>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
Content-Language: en-US
Autocrypt: addr=mairacanal@riseup.net; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNJE1hw61yYSBDYW5hbCA8bWFpcmFjYW5hbEByaXNldXAubmV0PsLAkQQTAQgAOxYhBPjk
 XX0BFncHKaZ30T/zDop2iPqqBQJnAsxsAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJED/zDop2iPqqIMIH/imTDQNi2FQpXG9z6fA6Kg5jOZQfBgYMUmzxA3y+5s7I6Ily0rci
 vdRwki89noYtjXB/P+9rSnhRq4KsXh+E3k0AHYt1VQgczMlnHADcXdr2XZopTqqCkNMH4MPd
 JoT2rx63uGBDhgX530ohZKOM3FN609+5SlBrUBEHC3ynZAH+CBbr4CnD1Z44RUWldDRJjxuF
 I+mm7lMYR0Ybb3eYqkBw3f8h1rhwhVYouc1Iiynlrykf0BKsmOTxA56Fyuc4LxkjHoVC5/pr
 4uwMD0Oz4GQpX1d0S6C59hvMyXwXUkID+cVMhvNdEeR2DV05aUmUrAS+8BsgxrK0Y//oR3PS
 irrOwE0EZwLDLAEIAMU1PHZ6syur4Dg0wltgOkgM3Lys7cWnuGI0cDdUrhoSUdorCYEB6Dh+
 qAiLVl3NQhgFp3IunaIdQyb22we7r5EJW3jcXiM9Dsx0ogfqW9bLLk99R8+kGRW1+KvnK63o
 DyIa/tMXg4ujLbvqWmKayO1EhhRYw1LyVH9+pCtMrhdl1DgZRdG3gkOyYXPlKCPQJJr5eLB1
 K2Sc1yzHmowEZ0gV03IoOoevzRVZK9ZotbrmXyETQpMQhPEEWHm2S0lsQVa94e3bTlJKtgsy
 9pEQik9qypJmK7wSU6kr3ytwWu0Kw4N7MxHvnxDaS94B7R+of10BfdhDrpZuUuaNCPnHkRMA
 EQEAAcLAdgQYAQgAIBYhBPjkXX0BFncHKaZ30T/zDop2iPqqBQJnAsMsAhsMAAoJED/zDop2
 iPqqSM0H/jQHDQwV1hxgN5YL2LzlN9fopPW299MWeyKivTCIuk6Wai+3MTcGfhQCthm1Focv
 v4D5F4rdoAgCbI6P0BCiYu2YfCIBzfo34pveNkGTpFPqf2BHL6gb12tM6ltLGH8gMZK3/zmX
 05zTRE6/rgSjWkBjtr5J+QF+ZfMzJfSwh9/yHmm6J4t+ahIaA/2jNCqX/dz4QryRmw+J9Q50
 Ya8ZtbhHUOh1I1oIRIwviYfcVLyXKNrVE3qcODsLj8Tr7bj01GtZIIsWMhtSXJP+u63iczIo
 HrmBba2ldz/Lf+nJrWsFY7q4Zwg7lEcoVK46UYYBafpVvDhq+qXqR6Jf1hSDkBI=
In-Reply-To: <20260717111559.2759217-1-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17/07/26 08:14, Maíra Canal wrote:
> My university email will cease to exist in the next few days, so map it
> to a personal email address.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Acked-by: Maíra Canal <mairacanal@riseup.net>

> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index f4f18b06f2f1..6fe93913a910 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -539,6 +539,7 @@ Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
>   Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
>   Maharaja Kennadyrajan <quic_mkenna@quicinc.com> <mkenna@codeaurora.org>
>   Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
> +Maíra Canal <mairacanal@riseup.net> <maira.canal@usp.br>
>   Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
>   Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
>   Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>

