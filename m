Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0CDC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E5010E2A4;
	Mon, 17 Aug 2026 16:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="DUKxMzpv";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 218F110E2A4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786984836; x=1787589636; i=markus.elfring@web.de;
 bh=i+0shAmddluGlkdasno03D0BaOQp7GVSQ2XsXCsT0eo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DUKxMzpvh0PHijaWufpZON6JWAnXYCGx0Fv1GX9vaimPUK+wOpK3kEf7nLQVml3t
 0bNRvugJ1CwMQgNibJ/eYN0LlXbgGqJbMATfK46yMJ57H9hc63STCuYLCsJo/MrlT
 Ij6vCraL7G1O/J+KAy1IayZGWX2cJrMqz1WwjSIPBhg4mjwAwTYIpHsO2Ys1ZEBnd
 Bpqm078jXQtuew4ITEgu+0VBidY1BFvNaLWCKr1HLSUo01zgHOlrWW1NJ7IyRAu7G
 uGFn1XojOfbijEYfMrU3enqUPEAeaIpCKv80qpnNnpSQ/3fHk44QFTEltTFXmCuHt
 ognRZkMEqYWh59WUuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSFY-1xRNSM32EY-00UiRp; Mon, 17
 Aug 2026 18:40:36 +0200
Message-ID: <d593bdeb-e6f8-44d2-a444-e9197a8ed1a3@web.de>
Date: Mon, 17 Aug 2026 18:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/rocket: Check allocations before use
To: Triet Hoang <triet.hoang.dev@gmail.com>, dri-devel@lists.freedesktop.org, 
 Oded Gabbay <ogabbay@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:38HBkCXeJPF8UZaJYbpbZzq5mx3vaFZ2h8q8XBv/C4uNdIWjv0g
 W+6VhQdiNJlxRwXqrRuPUv+DoQKWejqy5UnVIc+wy6pT8b+luMy0t7IDp0McK6y4HBx9/cw
 VVk7DNonLNlR08Nua8gscPcyHrsnQmYNLvdP6vT2hWY7i/QUkjrt5rCkvwKN7THlUsKY+HM
 2eOyE8fbon1wUbsB/Zo1g==
UI-OutboundReport: notjunk:1;M01:P0:OSM0rVPH3JE=;A2OQ1ThpcN2RFhKAHCpFGcygbr6
 FCU14h9jyPomSIRXhIXMQcY51jus5aLRygz/eL2rVL4T42qYomEJFp4r/9+0DYnMm6zM8lBH8
 EBu0OxxqpZkQi3Ef/Hxnw05Ze0N8bCHZwQElWvgvHxOEh4AgfU41fo97wVB5scydhTm4PPlb5
 0GQ4I1Aan3Et+zifL31WhM+PXcDicwuY5i6KSzvwhnAmfn2CblFwpDP33MVy+hyR5Twxa4W4G
 +QyRaQwJ1Y+n8FVCxi7gPnuDMJsQPeLFIzfAezTPNDfNcaxC/UJCpZLOVx4EGRJBS8kBSxv36
 QuyDItmUEDFgJ7CtzLc7IDYOPEqOs/6jmi0D3Dx9HW+Gab+YYtm33fKbzb6Nqs1F1rmqp9u0T
 0nU+VOXs27x038KUjaVQnRIbcY84bREhuNCg2fHwZ6W4E+fG1hL3k7/fRdNU5eOwvJ28NMyzR
 PrlQVumLm/XJ3S8mABQGrfE240plUugbmmPqKF9xZwpyODw+itTI8UNU/stQ+W2/EuT5HOlZa
 ccSJSaybdlHzvF71Uu+dWx//KPl7HXRjZhfy4bm6pgxMd5ujPcT5ZZQNj8dD2+eQx9cXqTL1C
 FM278UyUuaCszKJsxP8xeVCF4c2UKuGrweGNyoVr4swW+5KehXtcenqzlGAwnF24uqRgBL2cd
 5HtCkN8F8Q+TNymwQYHhbgfvHDuKXY8SLjuxO4KMn/x9aJCe7yQZE5orj6nBspzgJXyYikMY7
 YInmy1PThLj2YcMDq1H9MDAechbQPU/wV1OyZ4sfwmdirSxmt+7y6ITIEqr7EM/77cRQOsMkx
 0fAX0hetUPtVkKQM3UDtw/E3b+fHSs1A833Ug7KjFJ80V35l3nOrVkq16VXdRi2h8U9TYLY+e
 CvQLxByiVXhFUYupdj/rA3XLPWjRSATkU7xAlAOsMmNrab6ge6HJmN0Bk3+BfSldTfkn2bGDs
 7J4LeYLMXbVj7LJkSkF3AMqp7FQpWY2JA5Uo4F4knb6r60hTvfFBQCyU+cJ3Uq5sfJGEdcQxu
 DLMIYd5o5Sow7TtkzYBU4WdmsyWwXzaK9dZ+Fd4baRP+omFhAcUzfwSQAq+IrOJm3C9DBCjgT
 MI5ne4d+OzCG9h+vpWEJNGbipg/Hh34/z92lvOxniduet2ha9Q1xgJA4YWl5zE18/eFzAbu0w
 NtDjXbhWtNBZiAfKuEpVmKMgm9xENcJkHUFnR/kJ0elHCxLZ1ahQIA5/N+uMajtWq1OAS/Klp
 7zCT9rJ2/O+cOXapuCPbv4GkDDkLsoEgb01+p2V+d2FgzjqvpAOzPofrLHxeGDAc+YRdpaxkq
 b+FUsxshMFtZpIH9wzL+BBv4qeewcyIVjUb/X1I3ZjsVd/BfNJt2V8rMVoXVghbchz0TrX//x
 KDgMxz10oUc44D7mX6AKx23pHxqTCAYyfvlTAtPUsbT743W1/f0NqfKrV1YYEs8TOuq+t09xH
 kSQ6toZSFCwG/B0IO+xnkraQqSsUqkW4mHevjnTCAFmBVJrLV0admq4krsSHSlTB58N5FB/wt
 bFX/BbWMb/Nw7rjP9aq6giAD6LAxhqXP/CB/g2Ng/grYi1htcJ5wwYLqJfPfcZlqZD5zWgmzB
 rd6qWyVRXxf4hSwdhaFOilmeJ8ncdUpuG1EJVtJH989IC7hhDsaeF9m/1TIQWLhio3zcsROZe
 CVW1L2jQ/91pIaEhkTxJ3GV5jpkOzYYTFYcc4FhkREzGsGT+mnys0XGwFiy+RI5Ga7BpS5jEQ
 PJRlVh1ZfND1Y7niNcabj58j+sjTD+AThWaBzDWjWLPG0BWxC+Bi72IbM9D0igFBxOxtG2gSW
 IDxNJP6JNaPLULora9iw4poMHWi4K0Upx0TacVikSU8jciLf4UPG0QbLxGmUH0G9XeLMXqt1G
 U6AcU3Mnhld1CJO3bKPtLkkkDU+qkq6Xt73CnZq4Ce8SWfTGkmNVFQ4NphB619HVbi/bXIAQZ
 3BDazKLS059UtLiFngfDUJzqwl5iOS7jxXQnd6JPoFiCdmI7qZb1Gks4Xnir8d9vFQnR5VQgE
 pV3XbCMFb5szmzTFBLxNwtRWyd8IAGY563YZRibk4QFDk1XEX/v7nFz8SKajuP281I39jauhE
 0d6LUSXsBtR95yejIbs/8tukmUD/nk9Em2e/l6wzBzRkQFej2IEkJykeVEgkxhoOXTSXmXvdL
 CpsZo8Aklx6f/e9UkEIKWJMzHgJcUFTsuw/PkRab/CgBz7uWTAd5BnKmmuAQqu+M90MgBtvz0
 +9iuHplELlZ5O0Z1GXMXHxjZNKURx40aCM2VmYQDhH16sOmUuj8VG3ca3xYbqtT1nq4sL3gxq
 FeVeDRj91RYEkK/pyXAf+mVK/uuSfXbC1PeDGzHL4O02TpSCCY3FE7TPicvB3y3tcEVEAUPTf
 fP+DucEQgwnYnbDNmxHfMnajW13MnX5Rwbqc3gQZCbywt5/KwDj5ULb51BDhDP4uza9IzAuo4
 kRV8U/zmJly9VltLl7mIGQwg5vfuAtVDJPXqaT25vyGL6RM/MmPUX/gyYr19J/mr6Rb//oAGT
 JLhjbVocz/3de8QtfI9OeWX/oyZuXjP2ubThb5jfzZx2QpQikQrP+Jx2cRK2tV/Nf9NsWYaxA
 6zMb2y4yhRVvOKWaql3rZjDrhWefmHWTFrmjd3aR5FfYCAbgMQAkLHNDl5TLq+iOSkWgVLacc
 WIujzn2oJKG/Uja3EZGxrrecX86aWHjpltxvsdk/tbzWGsIX98SuT7f+6edKGUFNEpYK+Ohuu
 vJbUNCYDTkmSRvVoTP1Kxsc3sivx4/uSK/ExKS0nWroLCKkLqilzY+bN1d0IAqGO7xRLGQ0S0
 qgrdyIY4QoupRh5yl38yGQsg54d4X8rpLDqxdJxwFMQa5yJluBpwqlwjCc0vD3D0e9QDMNiXj
 qo00DzU+oefz4r+jZq5+3xUY96S68pKpQ6UO6TP1wStvE2Fww6x6mQg62VnDjac6kCCCrWJ4g
 eLUhlGISOPj+HORTvEnlJHMXuaNbTtAEg+7b0imDlj/Iu/NCYY92s3zLbVg+vE5oA/7C4Up5W
 2cR1SaRv8yN+l5XsUKpuZlARzLzUYL+By/N8L3OhGmKcTjbm3LQSU+yuv7rd4THjMAFg/dFWx
 2mH/y7zTCtYmFYjr8EbX3OZC+reR09mGue9ONNDv+OvLJq1Q+guY/mCR5uZ7dsbfI04E/gZmo
 IROLHiBvQj0lH/QYsUIdyztG0TiA0u9Z8FIBkQQKs0FQg/nuh2x5rL7VO+xi5u1Dh++hvakG6
 w3Ktk9eamBwjnWbnWaUwD8lwHEOCg0/eTeDmk6+abUWg/ZYSr3C2sKO3bpRLGrRP3JghJvMQ0
 /+XfSgWbFEvbVDrMK8E8KB+OwX/eGT1FqnS74brRxOp4Qh2vPAZrLuP+w7dcorf8u//5PEf28
 pTyaGmlwJtJh7e/qheGAsHfXtqpyUMQGAoWSB86bsKT2DC34hWQevEl66AI4w30EeiIqSVZnX
 U2l/3xS3I13oz3O4uFd9vHeqwlbroLTYC/2Ls31KxdUbj2VGfauZB5tk4ivJH1jc8vEHc4RIL
 bjBhqeD3Iamm0AsTNzBvNJDrWcf4niBViW1aYLcA/6kH73fiKiP5z6aEUUHkSExnsTwFH7lm4
 alAX6ahawyVsHq4NnxluiW4w9uyfcz/MLsY0uqPdJZ1naaEVBvOSg6TqHPM7T5Jvn+RDNaBt2
 cfWpXZzrTTcov8E8e/a+1En3GGGcnQ1kKKFiHCLGVlEF6X5lVwLj5qGlY9nbEA8ymhgAC0B27
 NMQ8q6BHHikPg4mZtECPN6uDh7owOEyuLVJKRix7MO0/8AGlOGQDidQW+n09js2mihFn/lT6H
 nHpQHzPcKYgGo5kgZPOkJyYaWTHwYRv0fZGqTJwIewoyCUcmjEbICs6OqhUQ5GFPgJxiaEQD1
 QslhEsGRL+dlrwufnpYLIR+7kur3Vg9BLbvXsQK7V7S/61n616RSsryn1BgrVqq+VM3IPvJr/
 3H9QSGgMFsvoFsAA4Ft9otodSxp0PCjEMa6j3XkULsSfNLrJT2QMtdic0qaBQ75oCdOd31PvE
 +Ewsgtv8zfLvVE9dBZxn0/ScoMPycvtMXjddYUTX8ZhWUkILYqY1naJUix/0SroMixZnIH6Dm
 TFztQrfK3gZWWUTa0drGs2lMpYyViDW//kVIfgyPvBSWl09TJ/mpOoWQOXWTVfCNNpo2S06Fh
 rqlN++trAMh+OLY2ZpO1jWD1rf6yiz/Q5bUGiP+0F1vq7WiWXTIHPt2OvkG6wTI+gjQVRk7KX
 KP4W8iTBGPy/8y6CYA8CErugZh8r3l7Xmk+AsKE5TVcS7L33/tCJxaszYjtIpzf8Ze1fBFHIM
 fFZEf0E5UEb6IVJVpGu1FFjTQmOr+HjRYnXWm1LO37dXeNK4OAtGmJkLfwdHFzR37uaWJ+bCa
 HaQ+Ee5btc67cbC8gV66Ip4NSOUZ6zfkD4fYpvyO23619Yw3z96njwQMo2PNqwEfwCnWCC8t9
 JeqVSV6WrdgEbADvUsg4BHfOl5r28OXnISvNVfIEdTGlULo2v58vh0eFo0/HKOHpnS72jEHdT
 Ptp4jBZEnMJPJDscv7MHs+PU0jlQJHBBaz+lbo8eTRqSuIVdhP1t0EoRKdS8Fzv3qQLv2kkMR
 /LQ3WjofXVldxq7v8wf4moeChOllB/T5XORORL0uD94/Rk4hFk2HXmsa/Q3lrbWS0jgzHmbtY
 adM9auxLwkx009lgcaFplFXmHGvHB9Bos20+qGFsgN9USvvP4Ff3zgH7NEGCfwpSmW9HZyNLV
 qcEYyvxGXRWojOSA6PG2T0JPDo+4TJpYKvPJUaJVw1E9XwJVHl+wzuuj7ym50n1oIdTRHml3z
 cRuX+g1vYwX+yJaBFE/jtf6l4QnHQe0dS9bvk4x7oDsl+qVe4TAiaLlFSxU5WPP4vcDnqvxMc
 cy+WqQbSTiui9+KyDNmczt9nHxZ1JAP0Dvzdjz9MYiD/gM5pCC5t0859UOOZ7cJk5f4sPRdFJ
 wJRbsV8iX4gEMoJRaTQZKTfkHSLK5IDdh2jhLO+td6eA8V2dBMPFBveVzMH1/7nzWFwEcW13k
 uB9OSPY+CL0WI9YXNdbTUiPNUa1mjmNJ9e/BOsZtIgaGl3p1q+SB9WCKcsAllkdFk5lqau91h
 9BhTXd+/MPSK8TPBntQvLkf2wnLQ8l4CcUhgPvlBXYd8CLViBIu1XtEsbEdsQ5QPlzSzDf4e8
 pbNMec0rN93js97xt18o3YGd3T08UAOqRspu5SxWpE1H+Pi6NsX81VeFZ7EDGOgDL817KhsFT
 6TMTgGvM/O85+E2RKMZXCzjHzVzQVyRxdxeGvbeLlOzfJb3Zmzlqz0BMXIORf+B+4K/nXqOoQ
 9ziA37s5j8nDaQt+Evnh+532AyXXRVX7G67RQnIYFLLf9ANFY7XU/qiPa2ubbF06JEMQ2bKZs
 sQEdW1OENOC2m8d33G9hAIC0oSDuDIPAVwma/4BigN7LVUBIoK8BVAErDhnrnEqMGMGCjZV0O
 cEiaeJFqQcd+ZMOMcvnvHFf3v48pcOBXuM1CM43ZBuvXVqpkjxzGxAFgeBSlpuKTEJ9s+8yhA
 O/RgIygbAhiqE/FQCySF7huJ8kPV8Msiat/P3zSTX7Eq/VI+OBHctZ/PrAKl/9PgbsXpfs/Dz
 9d7d9ip0OufVXNp/zRnjdurutkKdGLhMHWMJU7jq4Z9SuN9unBhH9S0FgMILs8t4oCyeCzFWA
 mzoIfacCBqg/Eqf2OUNCyJ2uyXh4RAakH+KNH3YO2C0Ggc20qFh2EWWuQLzKP0TAr9RUkHd+a
 oyyCOFeNdOsW7c64jggRQpa/2/0yZq8tuuAkaBJna/qAR009o7KByrcBJL6ewYocVzrYpkcPU
 YTrkTNgUEJjL82c9TqXRvy/4+fS3Py35lNPsGEk3snFbLS4tYv+Y1vVnUTSDO5Co7oKhq3ENb
 w925cUZAVDo+HBtOZvCDE6Hh2f3/0eh4QZ8Tn+7lt+yH++CY06a+p0MPt2KVghRIkQryy9jdq
 f71E/oAnQYFxkV6fFCxuldwb0EvdxzDYuIAJUzN/ZWk0Y3HOPuzxvnkKo4
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

=E2=80=A6
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -192,6 +192,9 @@ static int rocket_job_push(struct rocket_job *job)
> =20
>  	bos =3D kvmalloc_array(job->in_bo_count + job->out_bo_count, sizeof(vo=
id *),
>  			     GFP_KERNEL);
=E2=80=A6

I see opportunities for corresponding collateral evolution.
How do you think about to apply the attribute =E2=80=9C__free(kvfree)=E2=
=80=9D also in such
a function implementation by another update step?
https://elixir.bootlin.com/linux/v7.2-rc7/source/include/linux/slab.h#L142=
0

Regards,
Markus
