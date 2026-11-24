Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCA606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=jq7D+GoX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tempos-project.org header.i=@tempos-project.org header.a=rsa-sha256 header.s=dkim header.b=nNouExC8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesp.com.br header.i=@renesp.com.br header.a=rsa-sha256 header.s=2021 header.b=LxHYzh/x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A29D10F9E6;
	Wed, 25 Nov 2026 08:41:21 +0000 (UTC)
Received: from mail.renesp.com.br (mail.renesp.com.br [45.231.133.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D2410E89B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
 s=2021; t=1795534654;
 bh=VNf1YCXsU2lc0Yniio6DD5hquzwsa6ugL4GkaPD95nE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=jq7D+GoXH9Z0wYvqOxqnJwGW/YMR80cqtFO/05T+qvao6vfieNQJq2J1KNBLTwlwH
 OHmmAgW9lRsCPvm9gh8kDCcFb/LYi3B9/MJBewBXQubKH9iqLG5xmIYQtNfDZLpCCT
 Q4uwExsZXfZb4usnQdtWERf57v6LSI70aUbXJTQw=
Received: from renesp.vps (renesp.com.br [127.0.0.1])
 by mail.renesp.com.br (Postfix) with ESMTP id 4jYn4Z26j2z3wvN
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:37:34 -0300 (-03)
Authentication-Results: renesp.vps (amavis); dkim=pass (1024-bit key)
 reason="pass (just generated, assumed good)" header.d=tempos-project.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 tempos-project.org; h=content-transfer-encoding:content-type
 :message-id:user-agent:references:in-reply-to:subject:to:from
 :date:mime-version; s=dkim; t=1795534653; x=1798126654; bh=VNf1Y
 CXsU2lc0Yniio6DD5hquzwsa6ugL4GkaPD95nE=; b=nNouExC8qzWkB39rY7coW
 GUr8qSSyPsmH3A0f2DfX8v9sLFMclSbACjx2JVeASPiz1IGw2pjIzqv1BJalJJT4
 tOhTxaIodXUJQesE2Du6rXl6GDkhjtmYHPSur6oym29aPnIMxE/BYU+UStVFfM21
 MedxvXbv5d9L3NP2PMrFsRaka2SGELBwbGXsEkhZgPAs4q8YgCHJywye0omjeWA3
 /HZz+hopdRmZzgWrIsiT3cHWVt6/QJzbJEae6P51l/PcHnytR8ZxN8Tq03HyPyqT
 zcaDPXwKc2IIm4iRd/n1tEIbcNJgQ/wdY4ZJDr8vGNFctnHFpw47SaoFghA8VezH
 w==
X-Virus-Scanned: Debian amavis at renesp.vps
X-Spam-Score: 2.21
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: renesp.vps (amavis); dkim=fail (1024-bit key)
 reason="fail (body has been altered)" header.d=renesp.com.br
Received: from mail.renesp.com.br ([127.0.0.1])
 by renesp.vps (renesp.vps [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 97F2hG8nzx7F for <dri-devel@lists.freedesktop.org>;
 Tue, 24 Nov 2026 12:37:33 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=renesp.com.br;
 s=2021; t=1795534652;
 bh=OeuQovqVTmmyTNTCh34NkbNDjZ/iqKBQ4Lgvm2gPQ9s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=LxHYzh/xQQ7Gj5nEkVc/jgCsMWY0n9JljeuDZZtC6BpX5NJ9h121bqw8ZhwOfJfZr
 x1QL//WRuhFrIKRFS0XnH8pyfDmM90n6FlXMTdabr6Ji5dD4na3WliJTFd8se7qupD
 DRv9oe+nd6rWntEoUZCDxgEM2qVlvSxOSD3YZu5M=
Received: from mail.renesp.com.br (renesp.com.br [127.0.0.1])
 by mail.renesp.com.br (Postfix) with ESMTPSA id 4jYn4W6fbbz3wvJ;
 Tue, 24 Nov 2026 12:37:31 -0300 (-03)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Nov 2026 16:37:31 +0100
From: =?UTF-8?Q?Ren=C3=AA?= <rene@renesp.com.br>
To: Murali Krishna <muralikrishna2444b@gmail.com>
Cc: anandu.e@oss.qualcomm.com, srini@kernel.org,
 ekansh.gupta@oss.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 jorge.ramirez@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 3/3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
In-Reply-To: <20261124144754.99753-1-muralikrishna2444b@gmail.com>
References: <20261117-interrupted-invoke-v4-v4-3-2320a8a7eda2@oss.qualcomm.com>
 <20261124144754.99753-1-muralikrishna2444b@gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <e6fd92e5bb6605ff3591c7813ac22055@renesp.com.br>
X-Sender: rene@renesp.com.br
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anandu,

I tested this series on a Qualcomm IQ-8275 EVK (QCS8275), backported to
a 6.18-based kernel. A llama.cpp process using the CDSP was killed
(SIGKILL) with invocations in flight, three times in a row: each time
its ~1.9 GB of DMA buffers were released at close, and the restarted
process got a context bank and loaded the model again without errors.
Without a fix, the buffers stayed attached to the context bank and the
next process failed to map its own.

Tested-by: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>

This also fixes the leak I sent a separate patch ([1], as mentioned by
Murali Krishna), so please consider that one superseded by this series.

[1]=20
https://lore.kernel.org/r/20261124122011.2912030-1-rene@renesp.com.br

Thanks,
Ren=C3=AA


On 2026/11/24 15:47, Murali Krishna wrote:
> On Tue, 17 Nov 2026 15:09:47 +0530, Anandu Krishnan E wrote:
>> The same unreachable-orphan problem exists for a timed-out kernel
>> invoke (-ETIMEDOUT, only possible when kernel=3Dtrue): the bail: path
>> used to unconditionally unlink the context from fl->pending before
>> dropping its reference, even though the DSP may still answer later.
>> Leave it linked on fl->pending in that case instead, so
>> fastrpc_notify_users() can still find and release it if the channel
>> is torn down before that answer arrives.
>=20
> I am new to this driver, so please treat this as an observation rather
> than a review. I applied 1/3 and 2/3 to char-misc-next (917fcbf03) and
> read 3/3 against that tree.
>=20
> The -ETIMEDOUT claim does check out: fastrpc_wait_for_response() only
> returns it from the kernel branch's wait_for_completion_timeout(), the
> user branch uses wait_for_completion_interruptible(), and
> poll_for_remote_response() converts its own timeout into -EIO.
>=20
> My question is what then happens to such a context at fd close.
>=20
> Once 1/3 removes the loop in fastrpc_user_free(), no path drains
> fl->pending any more: fastrpc_notify_users() completes the contexts on
> it but neither unlinks them nor drops a reference, and the drain 3/3
> adds to fastrpc_device_release() covers fl->interrupted only. A
> timed-out kernel invoke therefore keeps its worker reference, stays
> linked on fl->pending, and through the fastrpc_user_get() taken in
> fastrpc_context_alloc() keeps fl alive until an SSR runs
> fastrpc_notify_users(). If no SSR ever arrives, nothing releases it.
>=20
> The reasoning you already apply to fl->interrupted seems to cover this
> case as well: if fastrpc_release_current_dsp_process() succeeded then
> the DSP is done with the whole process, so a context sitting on
> fl->pending should be equally safe to release. Would it make sense to
> use release_err for both lists?
>=20
> What made me look was that fastrpc_release_current_dsp_process() is
> itself a kernel invoke, so it can be the call that times out. In that
> case release_err is non-zero, the fl->interrupted drain deliberately
> keeps the worker references, and that call's own context is also left
> behind on fl->pending -- so fl, its maps and its mmaps all stay
> allocated while fastrpc_session_free() has already marked the session
> reusable.
>=20
> That looks close to the behaviour Ren=C3=AA de Souza Pinto reports on
> QCS8275 after an adsprpcd init failure, in a thread where he has since
> offered to test this series on that board:
>=20
>  =20
> https://lore.kernel.org/linux-arm-msm/20261124141843.3967523-1-rene@ren=
esp.com.br/
>=20
> If that offer stands, an adsprpcd init failure followed by closing the
> fd might be a useful case to try, since it is exactly the path where
> release_err is non-zero.
>=20
> I built 1/3 and 2/3 on char-misc-next with COMPILE_TEST=3Dy under W=3D1
> with no new warnings. I have not applied 3/3 itself, and I have no
> Qualcomm hardware, so none of this is tested -- it is from reading the
> code only.
>=20
> Thanks,
> Murali Krishna
